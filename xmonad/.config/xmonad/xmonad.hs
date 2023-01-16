module Main (main) where

-- Imports
import XMonad
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig(additionalKeysP, additionalMouseBindings, mkKeymap, removeKeysP)
import XMonad.Util.SpawnOnce
import XMonad.Util.CustomKeys
import XMonad.Util.NamedScratchpad
import XMonad.Util.NoTaskbar
-- ?????? import XMonad.Util.WorkspaceCompare
import XMonad.Util.XUtils
import XMonad.Util.ActionCycle
import XMonad.Prompt
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Pass
import XMonad.Prompt.XMonad
import XMonad.Prompt.Unicode
import XMonad.Prompt.Input
import XMonad.Actions.UpdatePointer
import XMonad.Actions.CycleWS
import XMonad.Actions.WindowGo
import XMonad.Actions.TiledWindowDragging
-- import XMonad.Actions.NoBorders
import XMonad.Actions.Submap
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.FadeWindows
import XMonad.Layout
import XMonad.Layout.Simplest
import XMonad.Layout.SimplestFloat
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
-- import XMonad.Layout.Groups
-- import XMonad.Layout.Groups.Examples
-- import XMonad.Layout.Groups.Helpers
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.SimpleDecoration
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.ShowWName
import XMonad.Layout.Spacing
import XMonad.Layout.LayoutModifier
import XMonad.Layout.WindowNavigation
import XMonad.Layout.NoBorders
import XMonad.Layout.SubLayouts
import XMonad.Layout.DraggingVisualizer
import XMonad.Layout.WindowSwitcherDecoration
import XMonad.Layout.BoringWindows
import qualified XMonad.Layout.Renamed as R
import qualified XMonad.Layout.ToggleLayouts as T
import System.IO
import Data.Monoid
import qualified Data.Map as M

-- Colours
import Solarized

-- Function to update the pointer
updPointer = updatePointer (0.95, 0.95) (0, 0)

-- delKeys :: XConfig l -> [(KeyMask, KeySym)]
-- delKeys XConfig {modMask = modm} =
--     [ (modm .|. shiftMask, xK_Return)
--     , (modm, xK_p) ]

-- insKeys :: XConfig l -> [((KeyMask, KeySym), X ())]
-- insKeys conf@(XConfig {modMask = modm}) = []

-- Scratchpad config
scratchpads = [ ]

-- FadeWindows config (NEEDS COMPOSITOR RUNNING)
myFadeHook = composeAll [ opaque
                        , isUnfocused --> transparency 0.2
                        ]

-- Main
main :: IO ()
main = do
  xmonad
  $ withSB mySB
  . ewmhFullscreen
  . ewmh
  . docks
  $ cfg

cfg = def {
    borderWidth = 2
    , terminal = "alacritty"
    -- , keys = customKeys delKeys insKeys
    , startupHook = myStartupHook
    , workspaces = myWorkspaces
    , layoutHook = myLayoutHook
    , manageHook = myManageHook
    , logHook = fadeWindowsLogHook myFadeHook
    , handleEventHook = fadeWindowsEventHook
    , normalBorderColor = solarizedBase01
    , focusedBorderColor = solarizedRed
    , modMask = mod4Mask
    , XMonad.mouseBindings = Main.mouseBindings
    }
    `removeKeysP` [("M4-S-<Return>"), ("M4-p")]
    `additionalKeysP` myKeys
    `additionalMouseBindings` [
    ((0, 9), \w -> windows W.focusUp >> updPointer)
    , ((0, 8), \w -> windows W.focusDown >> updPointer)
    ]

myKeys = ([
    -- # XMonad keymap

    -- ## Window resizing using arrow keys

    -- Shrink window left
    ("M4-C-S-<L>", sendMessage Shrink)
    -- Expand window right
    , ("M4-C-S-<R>", sendMessage Expand)

    -- Mirror expand window up
    , ("M4-C-S-<U>", sendMessage MirrorExpand)
    , ("M4-M1-k", sendMessage MirrorExpand)

    -- Mirror shrink window down
    , ("M4-C-S-<D>", sendMessage MirrorShrink)
    , ("M4-M1-j", sendMessage MirrorShrink)

    -- Swap master window
    , ("M4-S-<Return>", windows W.swapMaster)

    -- ## Adjust window and screen spacing in spaced layouts
    -- Increase window spacing by 4px
    , ("M4-C-i", incWindowSpacing 4)
    -- Decrease window spacing by 4px
    , ("M4-C-d", decWindowSpacing 4)
    -- Increase screen spacing by 4px
    , ("M4-C-S-i", incScreenSpacing 4)
    -- Decrease screen spacing by 4px
    , ("M4-C-S-d", decScreenSpacing 4)
      
    -- ## Window navigation
    , ("M4-j", focusDown)
    , ("M4-k", focusUp)
    , ("M4-<L>", sendMessage (Go L) >> updPointer)
    , ("M4-<R>", sendMessage (Go R) >> updPointer)
    , ("M4-<U>", sendMessage (Go U) >> updPointer)
    , ("M4-<D>", sendMessage (Go D) >> updPointer)
    -- ## Window shifting
    , ("M4-S-<L>", sendMessage (Swap L) >> updPointer)
    , ("M4-S-<R>", sendMessage (Swap R) >> updPointer)
    , ("M4-S-<U>", sendMessage (Swap U) >> updPointer)
    , ("M4-S-<D>", sendMessage (Swap D) >> updPointer)    
    -- ## Stack based window navigation
    , ("M4-C-<R>", windows W.focusDown >> updPointer)
    , ("M4-C-<L>", windows W.focusUp >> updPointer)
    -- , ("M4-C-j", windows W.focusDown >> updPointer)
    -- , ("M4-C-k", windows W.focusUp >> updPointer)

    -- ## Sublayout grouping / ungrouping
    , ("M4-C-h", sendMessage $ pullGroup L)
    , ("M4-C-j", sendMessage $ pullGroup D)
    , ("M4-C-k", sendMessage $ pullGroup U)
    , ("M4-C-l", sendMessage $ pullGroup R)
    , ("M4-C-m", withFocused (sendMessage . MergeAll))
    , ("M4-C-u", withFocused (sendMessage . UnMerge))
    -- ## Sublayout focusing
    , ("M4-C-.", onGroup W.focusUp')
    , ("M4-C-,", onGroup W.focusDown')

    -- ## Killing programs
    , ("M4-x", kill)
    
    -- ## Workspace navigation
    , ("M4-M1-<R>", moveTo Next $ Not emptyWS)
    , ("M4-M1-<L>", moveTo Prev $ Not emptyWS)
    -- , ("M4-M1-j", moveTo Prev $ Not emptyWS)
    -- , ("M4-M1-l", moveTo Next $ Not emptyWS)
    , ("C-M1-<L>", moveTo Prev $ hiddenWS)
    , ("C-M1-<R>", moveTo Next $ hiddenWS)
    -- , ("M4-C-<R>", moveTo Next $ hiddenWS :&: emptyWS)
    -- , ("M4-C-<L>", moveTo Prev $ hiddenWS :&: emptyWS)
    -- , ("M4-S-<R>", shiftToNext >> nextWS)
    -- , ("M4-S-<L>", shiftToPrev >> prevWS)
    -- , ("M4-C-S-<R>", shiftTo Next (Not emptyWS) >> moveTo Next (Not emptyWS))
    -- , ("M4-C-S-<L>", shiftTo Prev (Not emptyWS) >> moveTo Prev (Not emptyWS))

    -- ## Toggle struts (bars etc...)
    -- ToggleStruts visual submap
    -- , ("M4-S-b", visualSubmap myWindowConfig . M.fromList $ map (\(k, s, a) -> ((0, k), (s, a)))
    --                 [ (xK_a, "Toggle all struts", sendMessage ToggleStruts)
    --                 , (xK_u, "Toggle only upper struts", sendMessage $ ToggleStrut U)
    --                 , (xK_d, "Toggle only lower struts", sendMessage $ ToggleStrut D)
    --                 , (xK_l, "Toggle only struts on the left", sendMessage $ ToggleStrut L)
    --                 , (xK_r, "Toggle only struts on the right", sendMessage $ ToggleStrut R)
    --                 ])
    
    -- Toggle spacing
    , ("M4-C-<Space>", sendMessage T.ToggleLayout)
    
    -- ## MultiToggle keybinds
    -- Toggle fullscreen (no borders)
    , ("M4-S-f", sendMessage $ Toggle NBFULL)
    -- Toggle normal fullscreen
    , ("M4-f", sendMessage $ Toggle FULL)
    -- Toggle mirroring of the current layout
    , ("M4-s", sendMessage $ Toggle MIRROR)

    -- ## Layout Groups keybinds
    -- , ("M4-C-s", splitGroup)
    -- , ("M4-C-l", nextOuterLayout)
    -- , ("M4-M1-u", swapGroupUp)
    -- , ("M4-M1-d", swapGroupDown)
    -- , ("M4-S-u", moveToGroupUp False)
    -- , ("M4-S-d", moveToGroupDown False)
    
    -- ## Keybinds for XP prompts (XMonad.Prompt prompts)
    -- Start pass prompt
    , ("M4-=", passPrompt solarizedDarkXPConfig)
    -- Start passGenerate prompt
    , ("M4-C-=", passGeneratePrompt solarizedDarkXPConfig)
    -- Start passEdit prompt
    , ("M4-S-=", passEditPrompt solarizedDarkXPConfig)
    -- Start passRemove prompt
    , ("M4-C-S-=", passRemovePrompt solarizedDarkXPConfig)
    -- Start xmonad prompt
    , ("M4-S-1", xmonadPromptC myXMonadCommands solarizedDarkXPConfig)
    -- Start unicode prompt
    , ("M4-S-u", unicodePrompt "/usr/share/unicode/UnicodeData.txt" solarizedDarkXPConfig)

    -- ## Help keybinds
    -- Run xmessage with a summary of the default keybindings
    , ("M4-S-/", helpCommand)
    -- Run xmessage with a summary of the default keybindings
    , ("M4-?", helpCommand)

    -- ## Media control (SECTION NOW REPLACED WITH VOLUMEICON)
    -- -- Increase volume
    -- , ("M4-<Page_Up>", spawn "pamixer -i 2")
    -- -- Increase volume
    -- , ("<XF86AudioRaiseVolume>", spawn "pamixer -i 2")
    -- -- Decrease volume
    -- , ("M4-<Page_Down>", spawn "pamixer -d 2")
    -- -- Decrease volume
    -- , ("<XF86AudioLowerVolume>", spawn "pamixer -d 2")
    -- -- Toggle mute volume
    -- , ("M4-<End>", spawn "pamixer -t")
    -- -- Toggle mute volume
    -- , ("<XF86AudioMute>", spawn "pamixer -t")
    
    -- ## Scratchpad activation keybinds
    -- TODO: Use visual submaps to visualize the keybinds
    -- , ("M4-M1-e", namedScratchpadAction scratchpads "Emacs")
    -- , ("M4-M1-<Return>", namedScratchpadAction scratchpads "qterminal")
    -- , ("M4-M1-f", namedScratchpadAction scratchpads "Caja")
    -- , ("M4-M1-s", namedScratchpadAction scratchpads "kitty")

    -- , ("M4-g", visualSubmap myWindowConfig . M.fromList $ map (\(k, s, a) -> ((0, k), (s, a)))
    --             [ (xK_t, "Tall", sendMessage $ JumpToLayout "Tall")
    --             , (xK_r, "Full", sendMessage $ JumpToLayout "Full")
    --             ])

    -- , ("M4-g", sendMessage $ JumpToLayout "Tall")


    -- ## Dynamic scratchpad activation keybinds
    -- Allocate 1st dynamic scratchpad
    , ("M4-C-a", withFocused $ toggleDynamicNSP "dyn1")
    -- Allocate 2nd dynamic scratchpad
    , ("M4-C-b", withFocused $ toggleDynamicNSP "dyn2")
    -- Toggle 1st dynamic scratchpad
    , ("M4-a", dynamicNSPAction "dyn1")
    -- Toggle 2nd dynamic scratchpad
    , ("M4-b", dynamicNSPAction "dyn2")

    -- ## Visual submaps
    -- "M4-n" Notification visual submap
    , ("M4-n", visualSubmap myWindowConfig . M.fromList $ map (\(k, s, a) -> ((0, k), (s, a)))
                    [ (xK_Return, "Clear notifications", spawn "dunstctl close-all")
                    , (xK_space, "Close current notification", spawn "dunstctl close")
                    , (xK_h, "Clear history", spawn "dunstctl history-pop")
                    ])

    -- "C-M1-<Delete>" Logout visual submap
    , ("C-M1-<Delete>", visualSubmap myWindowConfig . M.fromList $ map (\(k, s, a) -> ((0, k), (s, a)))
                            [ (xK_p, "Poweroff system (1min)", spawn "shutdown '+1'")
                            , (xK_r, "Restart system (1min)", spawn "shutdown -r '+1'")
                            , (xK_s, "Suspend system", spawn "systemctl suspend")
                            , (xK_l, "Logout user", spawn "loginctl kill-user yaslam") ])

    -- "M4-S-b" ToggleStruts visual submap
    , ("M4-S-b", visualSubmap myWindowConfig . M.fromList $ map (\(k, s, a) -> ((0, k), (s, a)))
                    [ (xK_a, "Toggle all struts", sendMessage ToggleStruts)
                    , (xK_u, "Toggle only upper struts", sendMessage $ ToggleStrut U)
                    , (xK_d, "Toggle only lower struts", sendMessage $ ToggleStrut D)
                    , (xK_l, "Toggle only struts on the left", sendMessage $ ToggleStrut L)
                    , (xK_r, "Toggle only struts on the right", sendMessage $ ToggleStrut R)
                    ])
    
    -- ## Keybinds for applications
    -- Restart XMobar
    , ("M4-]", spawn "killall -SIGUSR1 xmobar")
    -- Spawn terminal
    , ("M4-<Return>", spawn "alacritty")
    -- Run vim-select-file.sh script
    , ("M4-e", spawn "/bin/sh -c ~/stuff/vim-select-file.sh")
    -- Run dmenu-dark script
    , ("M4-d", spawn "dmenu-dark")
    -- Run rofi
    , ("M4-r", spawn "rofi -show drun")
    -- Run i3lock
    , ("M4-<Backspace>", spawn "i3lock -c000000 & sleep 1 && xset dpms force off")
    -- Headsetcontrol toggle keybind
    , ("M4-S-h", cycleAction "headsetcontrol" [ spawn "headsetcontrol -l0", spawn "headsetcontrol -l1" ])
    -- #
    ])
    where
      helpCommand :: X ()
      helpCommand = xmessage help

-- | Mouse bindings: default actions bound to mouse events
-- | (Taken from XMonad source)
mouseBindings :: XConfig Layout -> M.Map (KeyMask, Button) (Window -> X ())
mouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList
    -- mod-button1 %! Set the window to floating mode and move by dragging
    [ ((modMask, button1), \w -> focus w >> mouseMoveWindow w
                                          >> windows W.shiftMaster)
    , ((modMask .|. shiftMask, button1), dragWindow)
    -- mod-button2 %! Raise the window to the top of the stack
    , ((modMask, button2), windows . (W.shiftMaster .) . W.focusWindow)
    -- mod-button3 %! Set the window to floating mode and resize by dragging
    , ((modMask, button3), \w -> focus w >> mouseResizeWindow w
                                         >> windows W.shiftMaster)
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    , ((modMask, button4), \w -> focus w >> windows W.swapUp
                                         >> updPointer)
    , ((modMask, button5), \w -> focus w >> windows W.swapDown
                                         >> updPointer)
    -- , ((modMask, button8), \w -> focus w >> windows W.focusUp
    --                                      >> updPointer)
    -- , ((modMask, button9), \w -> focus w >> windows W.focusDown
    --                                      >> updPointer)
    ]

-- System tray command
trayerExpand    x = " --expand "          ++ x
trayerWidth     x = " --width "           ++ x
trayerEdge      x = " --edge "            ++ x
trayerAlign     x = " --align "           ++ x
trayerStrut     x = " --SetPartialStrut " ++ x
trayerDockType  x = " --SetDockType "     ++ x

trayerCmd = "/usr/bin/trayer"
            ++ trayerExpand "true"   -- true/false
            ++ trayerWidth "10"      -- max 100
            ++ trayerEdge "bottom"   -- none/bottom/top/left/right
            ++ trayerAlign "left"    -- left/right/center       
            ++ trayerStrut "true"    -- true/false
            ++ trayerDockType "true" -- true/false

-- StartupHook
myStartupHook :: X ()
myStartupHook = do
  setWMName "LG3D"
  spawnOnce "/usr/bin/xsetroot -cursor_name left_ptr"
  spawnOnce "/usr/bin/picom --config ~/.config/picom/picom-xmonad.conf"
  spawnOnce "/usr/bin/xsettingsd -c ~/.xsettingsd-solarized"
  spawnOnce "/usr/bin/dunst -config ~/.config/dunst/dunstrc-solarized"
  spawnOnce "/usr/bin/nitrogen --restore"
  spawnOnce "/usr/bin/conky -c ~/.config/conky/conky-moregap.conf"
  spawnOnce "/usr/bin/conky -c ~/.config/conky/conky-mpd.conf"
  spawnOnce "/usr/bin/dex ~/.config/autostart/*.desktop"
  spawnOnce "/usr/bin/xfce4-volumed-pulse"
  spawnOnce trayerCmd
  spawnOnce "/usr/bin/nm-applet"
  spawnOnce "/usr/bin/xss-lock --transfer-sleep-lock -- /usr/bin/i3lock -c 000000 --nofork"

-- Colourscheme for this config (based on zenburn <- NOT REALLY ANYMORE)
-- https://github.com/bbatsov/zenburn-emacs/blob/master/zenburn-theme.el
blue3     = "#797FBE"
blue2     = "#7CB8BB"
blue1     = "#6CA0A3"
blue02    = "#598C8E"
blue01    = "#528083"
blue      = "#4C7073"
bluelow   = "#24274B"
bluesap = "#005577"
green     = "#7F9F7F"
orange    = "#DFAF8F"
bg        = "#1B1B1B"
bg2       = "#5F5F5F"
fgText    = "#000000"
fgHLightC = "#DCDCCC"

-- PP config for appearance of workspaces etc.
myPP :: PP
myPP = def { ppCurrent         = xmobarColor fgText solarizedCyan
                                 . wrap " " " "
           , ppVisible         = xmobarColor fgText blue1
                                 . wrap " [" "] "
           , ppHidden          = xmobarColor fgText blue01
                                 . wrap " " " "
           --, ppHiddenNoWindows = xmobarColor fgText bluelow . wrap " " " "
           , ppUrgent          = xmobarColor fgText solarizedOrange . wrap " " " "
           , ppOrder           = \(ws:l:t:ex) -> [ws,l,t]++ex
           , ppSep             = " :: "
           , ppWsSep           = ""
           , ppLayout          = xmobarColor solarizedGreen ""
           , ppTitle           = shorten 40 
           }

-- Status bars
mySB :: StatusBarConfig
mySB = statusBarPropTo "_XMONAD_LOG_1" "xmobar" (pure myPP)

-- Theme for tab bars and other decorations
myTheme :: Theme
myTheme = def { fontName            = "xft:DejaVu Sans Mono:size=13"
              , activeColor         = solarizedBlue
              , activeBorderColor   = solarizedBlue
              , activeTextColor     = fgText
              , inactiveColor       = solarizedBase02
              , inactiveBorderColor = solarizedBase02
              , inactiveTextColor   = solarizedBase01
              }

-- This theme "hides" the text by making it the same colour as everything else.
-- 
mySubLayoutTheme :: Theme
mySubLayoutTheme = def { fontName            = "xft:DejaVu Sans Mono:size=13"
                         , activeColor         = solarizedOrange
                         , activeBorderColor   = solarizedOrange
                         , activeTextColor     = fgText
                         , inactiveColor       = solarizedBase02
                         , inactiveBorderColor = solarizedBase02
                         , inactiveTextColor   = solarizedBase01
                         -- , decoHeight          = 5
                       }

-- Theme for showSimpleWindow-based windows such as visual submaps
-- in X.A.Submap.
myWindowConfig :: WindowConfig
myWindowConfig = def { winFont = "xft:DejaVu Sans Mono:size=16"
                     , winBg   = solarizedBase03
                     , winFg   = solarizedBase0
                     , winRect = CenterWindow
                     }

-- Show workspace names config
mySWNConfig :: SWNConfig
mySWNConfig = def
    { swn_font    = "xft:SourceCodePro:Regular:size=70"
    , swn_bgcolor = solarizedBase03
    , swn_color   = solarizedBase1
    , swn_fade    = 0.3
    }

-- XP prompt config
brownishXPConfig :: XPConfig
brownishXPConfig = def {
  font                = "xft:SourceCodePro:Bold:size=16"
  , bgColor           = bg
  , fgColor           = fgHLightC
  , bgHLight          = blue3
  , fgHLight          = fgText
  , promptBorderWidth = 0
  , position          = Top
  , height            = 24
  , searchPredicate   = fuzzyMatch
  , sorter            = fuzzySort
  }

solarizedDarkXPConfig :: XPConfig
solarizedDarkXPConfig = def {
  font                = "xft:DejaVu Sans Mono:size=16"
  , bgColor           = solarizedBase03
  , fgColor           = solarizedBase0
  , bgHLight          = solarizedBase02
  , fgHLight          = solarizedOrange
  , promptBorderWidth = 0
  , position          = Top
  , height            = 24
  , searchPredicate   = fuzzyMatch
  , sorter            = fuzzySort
  }

myXMonadCommands :: [(String, X ())]
myXMonadCommands = [ ("shrink"              , sendMessage Shrink                               )
                     , ("expand"              , sendMessage Expand                               )
                     , ("next-layout"         , sendMessage NextLayout                           )
                     , ("default-layout"      , asks (layoutHook . config) >>= setLayout         )
                     , ("restart-wm"          , restart "xmonad" True                            )
                     , ("restart-wm-no-resume", restart "xmonad" False                           )
                     , ("xterm"               , spawn =<< asks (terminal .  config)              )
                     , ("run"                 , spawn "exec dmenu-dark"                          )
                     , ("kill"                , kill                                             )
                     , ("refresh"             , refresh                                          )
                     , ("focus-up"            , windows W.focusUp                                  )
                     , ("focus-down"          , windows W.focusDown                                )
                     , ("swap-up"             , windows W.swapUp                                   )
                     , ("swap-down"           , windows W.swapDown                                 )
                     , ("swap-master"         , windows W.swapMaster                               )
                     , ("toggle-tray"         , cycleAction "trayer" [ spawn "pkill trayer", spawn trayerCmd ] )
                    --  , ("sink"                , withFocused $ windows . sink                     )
                    --  , ("quit-wm"             , io exitSuccess                                   )
            ]

-- Spacing function definition for screen & window borders
-- Borders: (top bottom right left)
mySpacing :: Bool -> Integer -> Integer -> Bool -> Integer -> Integer -> Bool -> l a -> ModifiedLayout Spacing l a
mySpacing sB i j scB k l winB = spacingRaw sB (Border i i j j) scB (Border k k l l) winB

-- Function definition to add spacing to layouts using the mySpacing function,
    -- (ModifiedLayout Spacing l a)
defSpacing :: l a -> ModifiedLayout Spacing l a
defSpacing = mySpacing (l) (a) (b) (m) (c) (d) (n)
  where
    l = True        -- Should the smart border be enabled?
    m = True        -- Should the screen border be enabled?
    n = True        -- Should the window border be enabled?
    a = 20          -- top and bottom screen border
    b = 20          -- right and left screen border
    c = 6           -- top and bottom window border
    d = 6           -- right and left window border

-- Layouts
-- Dummy tiled layout only for spacing
tiled = R.renamed [R.Replace "Tall"]
        $ draggingVisualizer
        $ mkToggle (single MIRROR)
        $ ResizableTall 1 (3/100) (1/2) []

tiledDeco = R.renamed [R.Replace "Tall"]
            -- $ noFrillsDeco shrinkText myTheme
            $ windowSwitcherDecoration shrinkText myTheme
            $ boringWindows
            $ addTabs shrinkText mySubLayoutTheme $ subLayout [] Simplest
            $ tiled

tabs = R.renamed [R.Replace "Tabs"]
       $ noBorders
       $ addTabs shrinkText myTheme
       $ Simplest

-- Floating layout with decoration
floating = R.renamed [R.Replace "Floating"]
           $ noFrillsDeco shrinkText myTheme
           $ simplestFloat

-- Spacing Layouts
tiledSp = R.renamed [R.Replace "Spacing Tall"]
          $ defSpacing tiled

tiledSpDeco = R.renamed [R.Replace "Spacing Tall"]
              -- $ noFrillsDeco shrinkText myTheme
              $ windowSwitcherDecoration shrinkText myTheme
              $ boringWindows
              $ addTabs shrinkText mySubLayoutTheme $ subLayout [] Simplest
              $ defSpacing tiled

tabsSp = R.renamed [R.Replace "Spacing Tabs"]
         $ addTabs shrinkText myTheme
         $ defSpacing Simplest

-- Toggle between two layouts
tiledSpToggle = T.toggleLayouts tiledDeco tiledSpDeco
tabsSpToggle = T.toggleLayouts tabs tabsSp

-- LayoutHook 
myLayoutHook = windowNavigation
               $ mkToggle (NBFULL ?? EOT)
               $ avoidStruts
               $ smartBorders
               $ showWName' mySWNConfig
               $ mkToggle (FULL ?? EOT)
               $ tiledSpToggle ||| tabsSpToggle ||| floating

-- List of workspaces
myWorkspaces :: [String]
-- myWorkspaces = ["one","two","three","four","five","six","seven","eight","nine"]
myWorkspaces = map show [1..4]

-- ManageHook
doShiftAndGo :: String -> ManageHook
doShiftAndGo ws = doShift ws <+> doF (W.greedyView ws)

-- Inspiration from
-- https://github.com/shellbj/dotfiles/blob/85893a285c3e519c9c96cfa9f91db015a2709759/.xmonad/xmonad.hs
-- and
-- https://github.com/search?l=Haskell&q=myWorkspaces&type=Code
myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll . concat $
  [
    [isDialog --> doCenterFloat]
  , [isFullscreen --> doFullFloat]
  -- Steam ManageHooks
  , [className =? "Zenity" --> doCenterFloat]
  , [(title =? "Friends List") <&&> (className =? "Steam") --> doFloat]
  , [(className =? "Steam") <||> (title =? "Steam") --> doShiftAndGo (myWorkspaces !! 3)]
  , [className =? "pinentry-qt" --> doCenterFloat]
  , [(title =? "Library") <&&> (className =? "firefox") <||> (className =? "Firefox") --> doCenterFloat]
  ]

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "mod-Shift-/      Show this help message with the default keybindings",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "",
    "-- Workspaces & screens",
    "mod-[1..9]         Switch to workSpace N",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
