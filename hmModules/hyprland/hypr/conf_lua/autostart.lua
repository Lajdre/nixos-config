-- AUTOSTART

hl.on('hyprland.start', function()
  hl.exec_cmd('hyprsunset -t 3000')
  hl.exec_cmd('awww-daemon & ~/.config/scripts/wall.sh')
  hl.exec_cmd('waybar')
  hl.exec_cmd('swaync')
  hl.exec_cmd('hyprctl dispatch workspace 3')
  hl.exec_cmd('[workspace 1 silent] ghostty')
  hl.exec_cmd('brave')
end)
