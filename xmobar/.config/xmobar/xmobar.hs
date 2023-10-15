import Xmobar

config :: Config
config =
  defaultConfig
    { font = "DejaVuSansM Nerd Font 12",
      iconOffset = -2,
      allDesktops = True,
      alpha = 200,
      commands =
        [ Run XMonadLog,
          Run $ XPropertyLog "_XMONAD_TRAYPAD",
          Run $ Memory ["t", "Mem: <usedratio>%"] 10,
          Run $ Kbd [],
          Run $ Date "\xf00f0 %a %_d %b %Y <fc=#ee9a00>%H:%M:%S</fc>" "date" 10,
          Run Locks
        ],
      template = "%XMonadLog% }{ [%locks%] %kbd% | %date% | %memory% %_XMONAD_TRAYPAD%",
      alignSep = "}{"
    }

main :: IO ()
main = xmobar config  -- or: configFromArgs config >>= xmobar
