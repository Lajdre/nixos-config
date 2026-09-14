-- MONITORS

local ok, machine = pcall(require, os.getenv('HOME') .. '/.config/hypr_per_host/machine')
if not ok then
  machine = { output = 'eDP-1', mode = 'highres@highrr', scale = 1, hasBuiltinDisplay = true }
end

hl.monitor({ output = machine.output, mode = machine.mode, position = '0x0', scale = machine.scale })
hl.monitor({ output = '', mode = 'highresxhighrr', position = 'auto', scale = 1 })

-- Disable builtin display whenever an external monitor is present, re-enable when it's gone.
if machine.hasBuiltinDisplay then
  local builtinDisabled = false

  local function refresh()
    local externalConnected = false
    for _, m in ipairs(hl.get_monitors()) do
      if m.name ~= machine.output then
        externalConnected = true
      end
    end
    if externalConnected and not builtinDisabled then
      builtinDisabled = true
      hl.monitor({ output = machine.output, disabled = true })
    elseif not externalConnected and builtinDisabled then
      builtinDisabled = false
      hl.monitor({
        output = machine.output,
        mode = machine.mode,
        position = '0x0',
        scale = machine.scale,
        disabled = false,
      })
    end
  end

  hl.on('monitor.added', function()
    refresh()
  end)
  hl.on('monitor.removed', function()
    refresh()
  end)
  hl.on('hyprland.start', refresh)
  refresh()

  hl.bind('SUPER + SHIFT + P', function()
    refresh()
  end)
  hl.bind('SUPER + ALT + P', function()
    builtinDisabled = false
    hl.monitor({
      output = machine.output,
      mode = machine.mode,
      position = '0x0',
      scale = machine.scale,
      disabled = false,
    })
  end)
end
