import Xmobar

config :: Config
config =
  defaultConfig
    { font = "DejaVuSansM Nerd Font 12",
      iconOffset = -2,
      allDesktops = True,
      alpha = 200,
      position = TopH 26,
      commands =
        [ Run XMonadLog,
          Run $ Memory ["t", "Mem: <usedratio>%"] 10,
          Run $ Kbd [],
          Run $ Date "%a %_d %b %Y <fc=#ee9a00>%H:%M:%S</fc>" "date" 10
        ],
      template = "%XMonadLog% }{ %kbd% | %date% | %memory%",
      alignSep = "}{"
    }

main :: IO ()
main = xmobar config  -- or: configFromArgs config >>= xmobar
