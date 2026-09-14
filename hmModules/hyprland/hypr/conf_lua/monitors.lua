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
    local names = {} --
    for _, m in ipairs(hl.get_monitors()) do
      -- FALLBACK is the virtual output Hyprland spawns when no real monitor is active
      if m.name ~= machine.output and m.name ~= 'FALLBACK' then
        externalConnected = true
      end
      names[#names + 1] = m.name --
    end

    local f = io.open('/tmp/hypr-builtin-reenable.log', 'a') --
    if f then
      f:write(
        os.date('%Y-%m-%d %H:%M:%S')
          .. ' externalConnected='
          .. tostring(externalConnected)
          .. ' builtinDisabled='
          .. tostring(builtinDisabled)
          .. ' monitors='
          .. table.concat(names, ',')
          .. '\n'
      )
      f:close()
    end

    if externalConnected and not builtinDisabled then
      builtinDisabled = true
      hl.monitor({ output = machine.output, disabled = true })
    elseif not externalConnected and builtinDisabled then
      local f = io.open('/tmp/hypr-builtin-reenable.log', 'a') --
      if f then
        f:write(os.date('%Y-%m-%d %H:%M:%S') .. ' re-enable path fired\n')
        f:close()
      end
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
