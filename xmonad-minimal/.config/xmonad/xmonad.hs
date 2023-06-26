-- vim: tabstop=2 shiftwidth=2 expandtab
  {-# LANGUAGE TypeSynonymInstances #-}
  {-# LANGUAGE MultiParamTypeClasses #-}

import XMonad

import qualified XMonad.StackSet as W

import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.DynamicIcons

import XMonad.Util.EZConfig
import qualified XMonad.Util.ExtensibleState as XS
import XMonad.Util.Loggers

import XMonad.Actions.TiledWindowDragging

import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.Renamed
import XMonad.Layout.DraggingVisualizer

import qualified Data.Set as S
import qualified Data.Map as M
import Data.Foldable (for_)
import Data.Functor

import qualified XMonad.Util.Hacks as Hacks

myIcons :: Query [String]
myIcons = composeAll
  [ className =? "Chromium" --> appIcon "\xf268"
  , className =? "steam" --> appIcon "\xf04d3"
  , className =? "Pavucontrol" --> appIcon "\xf04c3"
  , className =? "XTerm" --> appIcon "\xf489"
  , className =? "Emacs" --> appIcon "\xe632"
  , className =? "Vmware" --> appIcon "\xea7a"
  , className =? "qpwgraph" --> appIcon "\xf07e5"
  ]

myIconConfig :: IconConfig
myIconConfig = def { iconConfigIcons = myIcons
                   , iconConfigFmt = iconsFmtAppend unwords }

mySB = statusBarProp "xmobar" (dynamicIconsPP myIconConfig myPP)

myPP :: PP
myPP = def { ppCurrent = xmobarColor "yellow" "" . wrap "[" " ]"
           , ppTitle   = xmobarColor "green" "" . shorten 40
           , ppVisible = wrap "(" ")"
           , ppUrgent  = xmobarColor "red" "yellow"
           , ppExtras  = [logTitles formatFocused formatUnfocused]
           , ppOrder   = \(ws:l:t:e) -> [ws, l] ++ e
           }
          where
            formatFocused = wrap "[" "]" . xmobarColor "#ff79c6" "" . shorten 50 . xmobarStrip
            formatUnfocused = wrap "(" ")" . xmobarColor "#bd93f9" "" . shorten 30 . xmobarStrip

main :: IO ()
main = xmonad . docks . ewmhFullscreen . ewmh $ withEasySB mySB defToggleStrutsKey def
          { modMask = mod1Mask
          , terminal = "xterm"
          , borderWidth = 2
          , manageHook = myManageHook
          , layoutHook = myLayoutHook
          , logHook = raiseSaved
          , handleEventHook = handleEventHook def
                              <> Hacks.trayerPaddingXmobarEventHook
          , XMonad.mouseBindings = Main.mouseBindings
          }

          `additionalKeysP`
          [ ("M-p", spawn "dmenu_run -fn 'DejaVu Sans Mono:pixelsize=18' -nf 'gray' -nb 'black' -sb 'red' -sf 'white'")
          , ("M-f", sendMessage $ Toggle Main.FULL)
          , ("<XF86AudioRaiseVolume>", spawn "pamixer -i2" )
          , ("<XF86AudioLowerVolume>", spawn "pamixer -d2" )
          , ("<XF86AudioMute>", spawn "pamixer -t" ) ]

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
    , ((modMask, button4), \w -> focus w >> windows W.swapUp)
    , ((modMask, button5), \w -> focus w >> windows W.swapDown)
    -- , ((modMask, button8), \w -> focus w >> windows W.focusUp
    --                                      >> updPointer)
    -- , ((modMask, button9), \w -> focus w >> windows W.focusDown
    --                                      >> updPointer)
    ]

iconPath a = "<icon=/home/yaslam/.config/xmobar/icons/" ++ a ++ "/>"

data StdTransformers = FULL          -- ^ switch to Full layout
  deriving (Read, Show, Eq)

instance Transformer Main.StdTransformers Window where
    transform Main.FULL         x k = k (renamed [Replace $ iconPath "layout-full.xbm"] Full) (const x)

myLayoutHook = mkToggle (Main.FULL ?? EOT)
               $ avoidStruts
               (tiled ||| mtiled ||| full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = renamed [Replace $ iconPath "layout-tiled.xbm"] $ draggingVisualizer $ Tall nmaster delta ratio

     mtiled   = renamed [Replace $ iconPath "layout-mtiled.xbm"] $ draggingVisualizer $ Mirror tiled

     full = renamed [Replace $ iconPath "layout-full.xbm"] $ Full

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

-- provided by geekosaur on IRC
data SavedWindow = SavedWindow (S.Set Window) deriving (Read, Show)

-- provided by geekosaur on IRC
instance ExtensionClass SavedWindow where
  initialValue = SavedWindow S.empty
  extensionType = PersistentExtension

-- use in ManageHook: className =? "whatever" --> saveWindow
-- provided by geekosaur on IRC
saveWindow :: ManageHook
saveWindow = ask >>= \w -> liftX (XS.modify (\(SavedWindow s) -> SavedWindow (S.insert w s))) >> doIgnore

-- use in logHook: no parameters
-- provided by geekosaur on IRC
raiseSaved :: X ()
raiseSaved = do
  SavedWindow s <- XS.get
  withDisplay $ \d -> for_ s $ io . raiseWindow d

-- this lets you have a floating window that is fully ignored
-- but also lets you control the placement of the ignored floating window
-- thanks to [Leary] on #xmonad for this
-- use like: mapAt (Rectangle x y w h) <> doIgnore
-- in the manageHook
mapAt :: Rectangle -> ManageHook
mapAt r = ask >>= \w -> liftX (tileWindow w r $> mempty)

myManageHook :: ManageHook
myManageHook = composeAll $
               [ className =? "XClock" --> mapAt (Rectangle 1760 30 150 150) <> saveWindow
               , className =? "XEyes" --> mapAt (Rectangle 1860 1020 60 60) <> saveWindow ]
