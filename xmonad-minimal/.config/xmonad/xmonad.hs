-- vim: tabstop=2 shiftwidth=2 expandtab

import XMonad
import qualified XMonad.StackSet as W
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Util.EZConfig
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import Data.Functor

mySB = statusBarProp "xmobar" (pure xmobarPP)

main :: IO ()
main = xmonad . docks . ewmhFullscreen . ewmh $ withEasySB mySB defToggleStrutsKey def
          { modMask = mod1Mask
          , terminal = "xterm"
          , borderWidth = 2
          , manageHook = myManageHook
          , layoutHook = myLayoutHook
          }
          `additionalKeysP`
          [ ("M-p", spawn "dmenu_run -fn 'DejaVu Sans Mono:pixelsize=18' -nf 'gray' -nb 'black' -sb 'red' -sf 'white'")
          , ("M-f", sendMessage $ Toggle FULL) ]

myLayoutHook = mkToggle (FULL ?? EOT) $ avoidStruts (tiled ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

-- this lets you have a floating window that is fully ignored
-- but also lets you control the placement of the ignored floating window
-- thanks to [Leary] on #xmonad for this
-- use like: mapAt (Rectangle x y w h) <> doIgnore
-- in the manageHook
mapAt :: Rectangle -> ManageHook
mapAt r = ask >>= \w -> liftX (tileWindow w r $> mempty)

myManageHook :: ManageHook
myManageHook = composeAll $
               [ className =? "XClock" --> mapAt (Rectangle 1760 30 150 150) <> doIgnore
               , className =? "XEyes" --> mapAt (Rectangle 1860 1020 60 60) <> doIgnore ] 
