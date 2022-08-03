module Main (main) where

-- Imports
import XMonad
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig(additionalKeysP, additionalMouseBindings)
import XMonad.Util.SpawnOnce
import XMonad.Util.CustomKeys
import XMonad.Util.NamedScratchpad
import XMonad.Util.NoTaskbar
-- import XMonad.Util.XUtils
import XMonad.Prompt
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Pass
import XMonad.Actions.UpdatePointer
import XMonad.Actions.CycleWS
import XMonad.Actions.WindowGo
-- import XMonad.Actions.NoBorders
-- import XMonad.Actions.Submap
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Layout.Simplest
import XMonad.Layout.SimplestFloat
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
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
import qualified XMonad.Layout.Renamed as R
import qualified XMonad.Layout.ToggleLayouts as T
import System.IO
import Data.Monoid
import qualified Data.Map as M

-- Function to update the pointer
updPointer = updatePointer (0.95, 0.95) (0, 0)

-- Delete and remap default XMonad keys
-- delKeys :: XConfig l -> [(KeyMask, KeySym)]
-- delKeys XConfig {modMask = modm} =
--   [ (modm, xK_k)
--   , (modm, xK_j)
--   , (modm .|. shiftMask, xK_j)
--   , (modm .|. shiftMask, xK_k)
--   , (modm, xK_h)
--   ]

-- insKeys :: XConfig l -> [((KeyMask, KeySym), X ())]
-- insKeys conf@(XConfig {modMask = modm}) =
--   [ ((modm, xK_l), sendMessage (Go R) >> updPointer) 
--   , ((modm, xK_j), sendMessage (Go L) >> updPointer)
--   , ((modm, xK_i), sendMessage (Go U) >> updPointer)
--   , ((modm, xK_k), sendMessage (Go D) >> updPointer)
--   , ((modm, xK_u), windows W.swapUp)
--   , ((modm, xK_o), windows W.swapDown)
--   , ((modm .|. mod1Mask, xK_o), sendMessage Expand)
--   , ((modm .|. mod1Mask, xK_u), sendMessage Shrink)
--   ]

-- Scratchpad config
scratchpads = [
  NS "Emacs" "emacsclient -c -a 'emacs'" (className =? "Emacs") nonFloating ,

  NS "qterminal" "qterminal" (className =? "qterminal") nonFloating ,
  -- NS "qterminal-floating" "qterminal -d" (title =? "qtermdd") defaultFloating ,

  -- Kitty terminal scratchpad that tries to mimick yakuake
  -- drop-down terminal in KDE.
  -- 0/6 of screen width from the left, 0/6 of screen height
  -- from the top, 3/3 of screen width by 1/6 of screen height
  NS "kitty" "kitty --class=scratchpad" (className =? "scratchpad")
    (customFloating $ W.RationalRect (0/6) (0/6) (3/3) (1/6)) ,
  
  NS "Caja" "caja" (className =? "Caja") nonFloating ]

-- Main
main :: IO ()
main = do
  xmonad $ withSB mySB . ewmhFullscreen . ewmh . docks $ def {
    borderWidth = 2
    , terminal = "gnome-terminal"
    , keys = customKeys delKeys insKeys
    , startupHook = myStartupHook
    , workspaces = myWorkspaces
    , layoutHook = myLayoutHook
    , manageHook = myManageHook
    , normalBorderColor = bg2
    , focusedBorderColor = blue2
    , modMask = mod4Mask
    , XMonad.mouseBindings = Main.mouseBindings
    }
    `additionalKeysP` [
    -- Window resizing using arrow keys
    ("M4-C-S-<L>", sendMessage Shrink)
    , ("M4-C-S-<R>", sendMessage Expand)
    , ("M4-C-S-<U>", sendMessage MirrorExpand)
    , ("M4-C-S-<D>", sendMessage MirrorShrink)
    -- Windows resizing using other keys
    , ("M4-M1-i", sendMessage MirrorExpand)
    , ("M4-M1-k", sendMessage MirrorShrink)
    , ("M4-;", sendMessage Expand)
    , ("M4-h", sendMessage Shrink)
    , ("M4-S-;", sendMessage MirrorExpand)
    , ("M4-S-h", sendMessage MirrorShrink)

    -- Adjust window and screen spacing in spaced layouts
    , ("M4-C-i", incWindowSpacing 4)
    , ("M4-C-d", decWindowSpacing 4)
    , ("M4-C-S-i", incScreenSpacing 4)
    , ("M4-C-S-d", decScreenSpacing 4)
      
    -- Window navigation
    , ("M4-<L>", sendMessage (Go L) >> updPointer)
    , ("M4-<R>", sendMessage (Go R) >> updPointer)
    , ("M4-<U>", sendMessage (Go U) >> updPointer)
    , ("M4-<D>", sendMessage (Go D) >> updPointer)
    -- Window shifting
    , ("M4-S-<L>", sendMessage (Swap L) >> updPointer)
    , ("M4-S-<R>", sendMessage (Swap R) >> updPointer)
    , ("M4-S-<U>", sendMessage (Swap U) >> updPointer)
    , ("M4-S-<D>", sendMessage (Swap D) >> updPointer)    
    -- Stack based window navigation
    , ("M4-C-<R>", windows W.focusDown >> updPointer)
    , ("M4-C-<L>", windows W.focusUp >> updPointer)
    , ("M4-C-j", windows W.focusDown >> updPointer)
    , ("M4-C-l", windows W.focusUp >> updPointer)
    -- , ("M4-;", windows W.focusUp >> updPointer)
    -- , ("M4-h", windows W.focusDown >> updPointer)

    -- Killing programs
    , ("M4-x", kill)
    
    -- Workspace navigation
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

    -- Toggle struts (bars etc...)
    , ("M4-S-b a", sendMessage ToggleStruts)
    , ("M4-S-b u", sendMessage $ ToggleStrut U)
    , ("M4-S-b d", sendMessage $ ToggleStrut D)
    , ("M4-S-b l", sendMessage $ ToggleStrut L)
    , ("M4-S-b r", sendMessage $ ToggleStrut R)
    
    -- ToggleLayouts keybinds
    , ("M4-C-<Space>", sendMessage T.ToggleLayout)
    
    -- MultiToggle keybinds
    , ("M4-<Return>", sendMessage $ Toggle NBFULL)
    , ("M4-f", sendMessage $ Toggle FULL)

    -- Keybinds for XP prompts (XMonad.Prompt prompts)
    , ("M4-=", passPrompt brownishXPConfig)
    , ("M4-C-=", passGeneratePrompt brownishXPConfig)
    , ("M4-S-=", passEditPrompt brownishXPConfig)
    , ("M4-C-S-=", passRemovePrompt brownishXPConfig)

    -- Run xmessage with a summary of the default keybindings
    , ("M4-S-/", helpCommand)
    , ("M4-?", helpCommand)

    -- Scratchpad activation keybinds
    -- TODO: Use visual submaps to visualize the keybinds
    , ("M4-M1-e", namedScratchpadAction scratchpads "Emacs")
    , ("M4-M1-<Return>", namedScratchpadAction scratchpads "qterminal")
    , ("M4-M1-f", namedScratchpadAction scratchpads "Caja")
    , ("M4-M1-s", namedScratchpadAction scratchpads "kitty")

    -- Keybinds for applications
    , ("M4-a c", spawn "/bin/bash -c ~/.xmonad-bash-scripts/kill-alarm.sh")
    , ("M4-a s", spawn "/bin/bash -c ~/.xmonad-bash-scripts/set-alarm.sh")
    , ("M4-c", spawn "greenclip print | sed '/^$/d' | dmenu -i -l 10 -p clipboard | xargs -r -d'\n' -I '{}' greenclip print '{}'")
    , ("M4-S-c", spawn "notify-send Clearing clipboard... && greenclip clear")
    , ("C-n <Space>", spawn "dunstctl close")
    , ("C-n <Return>", spawn "dunstctl close-all")
    , ("C-n h", spawn "dunstctl history-pop")
    , ("M4-r b", spawn "openrgb --profile blue-bright")
    , ("M4-r d", spawn "openrgb --profile blue-dark")
    , ("M4-r o", spawn "openrgb --profile off")
    -- , ("M4-h l", spawn "/bin/bash -c ~/.xmonad-bash-scripts/headset-lights-on.sh")
    -- , ("M4-h o", spawn "/bin/bash -c ~/.xmonad-bash-scripts/headset-lights-off.sh") 
    , ("M4-<Page_Up>", spawn "pamixer -i 2")
    , ("M4-<Page_Down>", spawn "pamixer -d 2")
    , ("M4-<End>", spawn "pamixer -t")
    , ("M4-S-e", spawn "emacs")
    -- , ("M4-r", spawn "dmenu_run_app")
    -- Logout LXQT session
    -- , ("M4-S-q", spawn "lxqt-leave")
    -- , ("M4-p", spawn "dmenu")
    -- Application keybinds to be used with function keys (KMonad remapped)
    , ("M4-e", raiseMaybe (spawn "emacsclient -s yusef-emacsd -c -a 'emacs'") (className =? "Emacs"))
    -- , ("M1-e", raiseMaybe (spawn "emacsd derived-from-windows-minimal") (className =? ""))
    , ("M4-M1-1", raiseMaybe (spawn "qterminal") (className =? "qterminal"))
    , ("M4-M1-2", raiseMaybe (spawn "brave-browser-stable") (className =? "Brave-browser"))
    , ("M4-M1-3", raiseMaybe (spawn "pcmanfm-qt") (className =? "pcmanfm-qt"))
    ]
    `additionalMouseBindings` [
    ((0, 9), \w -> windows W.focusUp >> updPointer)
    , ((0, 8), \w -> windows W.focusDown >> updPointer)
    ]
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

-- StartupHook
myStartupHook :: X ()
myStartupHook = do
  setWMName "LG3D"
  -- spawnOnce "/usr/bin/setxkbmap gb"
  -- spawnOnce "/usr/bin/picom --xrender-sync-fence"
  -- spawnOnce "sudo ~/.local/bin/kmonad ~/.config/kmonad/config.kbd"
  -- spawnOnce "/usr/bin/openrgb --profile blue-light-light"
  -- spawnOnce "/bin/bash -c ~/.fehbg"
  -- spawnOnce "/usr/bin/xfce4-power-manager --daemon"
  -- spawnOnce "/usr/bin/emacs --daemon"
  -- spawnOnce "/usr/bin/sv restart emacs-daemon" -- Temp Hack/Fix
  --spawnOnce "~/.xmonad-bash-scripts/set-alarm-no-gui.sh"
  -- spawnOnce "/usr/bin/caffeine"

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
myPP = def { ppCurrent         = xmobarColor fgText blue2 . wrap " " " "
           , ppVisible         = xmobarColor fgText blue1 . wrap " [" "] "
           , ppHidden          = xmobarColor fgText blue01 . wrap " " " "
           --, ppHiddenNoWindows = xmobarColor fgText bluelow . wrap " " " "
           , ppUrgent          = xmobarColor fgText orange . wrap " " " "
           , ppOrder           = \(ws:l:t:ex) -> [ws,l,t]++ex
           , ppSep             = " :: "
           , ppWsSep           = ""
           , ppLayout          = xmobarColor bluesap ""
           , ppTitle           = shorten 60
           }

-- Status bars
mySB :: StatusBarConfig
mySB = statusBarPropTo "_XMONAD_LOG_1" "xmobar ~/.config/xmobar/xmobar.cfg" (pure myPP)

-- Theme for tab bars and other decorations
myTheme :: Theme
myTheme = def { fontName            = "xft:SauceCodePro NF:Bold:size=13"
              , activeColor         = blue2
              , inactiveColor       = blue01
              , activeBorderColor   = blue3
              , inactiveBorderColor = blue01
              , activeTextColor     = fgText
              , inactiveTextColor   = fgText
              }

-- -- Theme for showSimpleWindow-based windows such as visual submaps
-- -- in X.A.Submap.
-- myWindowConfig :: WindowConfig
-- myWindowConfig = def { winFont = "xft:SauceCodePro NF:Bold:size=13"
--                      , winBg   = "white"
--                      , winFg   = blue2
--                      , winRect = CenterWindow
--                      }

-- Show workspace names config
mySWNConfig :: SWNConfig
mySWNConfig = def
    { swn_font    = "xft:SauceCodePro NF:Bold:size=70"
    , swn_bgcolor = "white"
    , swn_color   = bluesap
    , swn_fade    = 0.3
    }

-- XP prompt config
brownishXPConfig :: XPConfig
brownishXPConfig = def {
  font                = "xft:SauceCodePro NF:Bold:size=16"
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

-- Spacing function definition for screen & window borders
-- Borders: (top bottom right left)
mySpacing :: Bool -> Integer -> Integer -> Bool -> Integer -> Integer -> Bool -> l a -> ModifiedLayout Spacing l a
mySpacing sB i j scB k l winB = spacingRaw sB (Border i i j j) scB (Border k k l l) winB

-- Function definition to add spacing to layouts using the mySpacing function,
-- (ModifiedLayout Spacing l a)
defSpacing :: l a -> ModifiedLayout Spacing l a
defSpacing = mySpacing (l) (a) (b) (m) (c) (d) (n)
  where
    l = False    -- Should the smart border be enabled?
    m = True     -- Should the screen border be enabled?
    n = True     -- Should the window border be enabled?
    a = 20       -- top and bottom screen border
    b = 20       -- right and left screen border
    c = 6        -- top and bottom window border
    d = 6        -- right and left window border

-- Layouts
-- Dummy tiled layout only for spacing
tiled = R.renamed [R.Replace "Tall"]
        $ ResizableTall 1 (3/100) (1/2) []

tiledDeco = R.renamed [R.Replace "Tall"]
            -- $ noFrillsDeco shrinkText myTheme
            $ ResizableTall 1 (3/100) (1/2) []

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
          -- $ noFrillsDeco shrinkText myTheme
          $ defSpacing tiled

tabsSp = R.renamed [R.Replace "Spacing Tabs"]
         $ addTabs shrinkText myTheme
         $ defSpacing Simplest


-- Toggle between two layouts
tiledSpToggle = T.toggleLayouts tiledDeco tiledSp
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
  , [(className =? "Steam") <||> (title =? "Steam") --> doShiftAndGo (myWorkspaces !! 8)]
  , [className =? "pinentry-qt" --> doCenterFloat]
  , [className =? "lxqt-runner" --> doFloat]
  -- , [className =? "lxqt-notificationd" --> doIgnore]
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
