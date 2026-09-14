-- KEYBINDINGS

local mainMod = 'SUPER'

-- exec / close / float / fullscreen
hl.bind(mainMod .. ' + Q', hl.dsp.exec_cmd('ghostty'))
hl.bind(mainMod .. ' + B', hl.dsp.window.close())
hl.bind(
  mainMod .. ' + M',
  hl.dsp.exec_cmd(
    "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
  )
)
hl.bind(mainMod .. ' + E', hl.dsp.exec_cmd('kitty yazi'))
hl.bind(mainMod .. ' + V', hl.dsp.window.float({ action = 'toggle' }))
hl.bind(
  mainMod .. ' + R',
  hl.dsp.exec_cmd("rofi -show drun -show-icons -font 'Agave Nerd Font 17' -theme purple")
)
hl.bind(mainMod .. ' + F', hl.dsp.window.fullscreen({ action = 'toggle' }))
hl.bind(mainMod .. ' + S', hl.dsp.exec_cmd('wlogout'))

-- waybar reload (press + release + O)
hl.bind(mainMod .. ' + P', hl.dsp.exec_cmd('pkill -SIGUSR1 waybar'))
hl.bind(mainMod .. ' + P', hl.dsp.exec_cmd('pkill -SIGUSR1 waybar'), { release = true })
hl.bind(mainMod .. ' + O', hl.dsp.exec_cmd('pkill -SIGUSR1 waybar'))

-- scripts
hl.bind(mainMod .. ' + U', hl.dsp.exec_cmd('.config/scripts/wall.sh'))
hl.bind(mainMod .. ' + Y', hl.dsp.exec_cmd('.config/scripts/pickWall.sh'))

-- Laptop brightness
hl.bind('ALT + Page_Up', hl.dsp.exec_cmd('brightnessctl set +5%'), { repeating = true })
hl.bind('ALT + Page_Down', hl.dsp.exec_cmd('brightnessctl set 5%-'), { repeating = true })

-- Screenshots
hl.bind('Print', hl.dsp.exec_cmd('~/.config/scripts/screenshots.sh rc'))
hl.bind('SUPER + Print', hl.dsp.exec_cmd('~/.config/scripts/screenshots.sh rf'))
hl.bind('CTRL + Print', hl.dsp.exec_cmd('~/.config/scripts/screenshots.sh ri'))
hl.bind('SHIFT + Print', hl.dsp.exec_cmd('~/.config/scripts/screenshots.sh sc'))
hl.bind('SUPER + SHIFT + Print', hl.dsp.exec_cmd('~/.config/scripts/screenshots.sh sf'))
hl.bind('CTRL + SHIFT + Print', hl.dsp.exec_cmd('~/.config/scripts/screenshots.sh si'))
hl.bind('ALT + Print', hl.dsp.exec_cmd('~/.config/scripts/screenshots.sh p'))

-- Focus (vim keys, h/l swapped)
hl.bind(mainMod .. ' + l', hl.dsp.focus({ direction = 'left' }))
hl.bind(mainMod .. ' + h', hl.dsp.focus({ direction = 'right' }))
hl.bind(mainMod .. ' + k', hl.dsp.focus({ direction = 'up' }))
hl.bind(mainMod .. ' + j', hl.dsp.focus({ direction = 'down' }))

-- Switch workspaces / move active window to workspace
for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod .. ' + ' .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. ' + SHIFT + ' .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces
hl.bind(mainMod .. ' + mouse_down', hl.dsp.focus({ workspace = 'e+1' }))
hl.bind(mainMod .. ' + mouse_up', hl.dsp.focus({ workspace = 'e-1' }))

-- Move/resize windows with mouse
hl.bind(mainMod .. ' + mouse:272', hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. ' + mouse:273', hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
  'XF86AudioRaiseVolume',
  hl.dsp.exec_cmd('wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+'),
  { locked = true, repeating = true }
)
hl.bind(
  'XF86AudioLowerVolume',
  hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-'),
  { locked = true, repeating = true }
)
hl.bind(
  'XF86AudioMute',
  hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'),
  { locked = true, repeating = true }
)
hl.bind(
  'XF86AudioMicMute',
  hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle'),
  { locked = true, repeating = true }
)
hl.bind(
  'XF86MonBrightnessUp',
  hl.dsp.exec_cmd('brightnessctl -e4 -n2 set 5%+'),
  { locked = true, repeating = true }
)
hl.bind(
  'XF86MonBrightnessDown',
  hl.dsp.exec_cmd('brightnessctl -e4 -n2 set 5%-'),
  { locked = true, repeating = true }
)
