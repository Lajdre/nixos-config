-- WINDOWRULES

-- Fullscreen
hl.window_rule({
  match = { class = 'Gimp.*' },
  fullscreen = true,
})

-- Floating
hl.window_rule({
  match = { class = 'swayimg' },
  float = true,
  size = { 2500, 1300 },
})

hl.window_rule({
  match = { class = 'mpv|xarchiver|com\\.obsproject\\.Studio|ffplay' },
  float = true,
})

hl.window_rule({
  match = { class = 'kitty' },
  float = true,
  center = true,
  size = { 1900, 1200 },
})

-- Common Modals
local modalTitles = { 'Open', 'Choose Files', 'Save As', 'Confirm to replace files', 'File Operation Progress' }
for _, title in ipairs(modalTitles) do
  hl.window_rule({
    match = { title = title },
    float = true,
    center = true,
  })
end

hl.window_rule({
  match = { class = 'xdg-desktop-portal-gtk' },
  float = true,
  center = true,
})

hl.window_rule({
  match = { title = 'Volume Control' },
  float = true,
  center = true,
  size = { 800, 1200 },
})

-- Workspaces
hl.window_rule({
  match = { initial_class = 'brave-browser' },
  workspace = '2 silent',
})

-- Ignore maximize requests from all apps
local suppressMaximizeRule = hl.window_rule({
  name = 'suppress-maximize-events',
  match = { class = '.*' },
  suppress_event = 'maximize',
})
-- suppressMaximizeRule:set_enabled(false)

-- Fix some dragging issues with XWayland
hl.window_rule({
  name = 'fix-xwayland-drags',
  match = {
    class = '^$',
    title = '^$',
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },
  no_focus = true,
})
