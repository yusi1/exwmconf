import Xmobar

config :: Config
config =
    defaultConfig
      { font = "DejaVu Sans Mono Regular 14",
        additionalFonts = [ "Noto Emoji 14" ],
        textOffsets = [0, -2],
        allDesktops = True,
        alpha = 200,
        position = TopSize L 100 24,
        commands =
          [ Run $ XPropertyLog "_XMONAD_LOG_1",
            Run $ Memory ["-t", "<usedratio>% (<cache>M)"] 10,
            Run $ Kbd [("gb", "⌨️ <fc=lightgreen>GB</fc>")],
            Run $ Date "<fn=2>🕛</fn> %a %_d %b %Y <fc=#ee9a00>%H:%M:%S</fc>" "date" 10,
            Run $ Cpu ["-t", "<fn=2>💻</fn> <fc=#ee9a00>U:<user>% S:<system>%</fc> <fc=gray>I:<idle>%</fc>"] 10,
            Run $ BatteryP ["BAT1"] ["-t", "<fn=2>🔋</fn> <timeleft> (<left>%)"] 600
          ],
        template = "%_XMONAD_LOG_1% }{ %kbd% | %memory% | %cpu% | %battery% | %date%",
        alignSep = "}{"
      }

main :: IO ()
main = xmobar config  -- or: configFromArgs config >>= xmobar
