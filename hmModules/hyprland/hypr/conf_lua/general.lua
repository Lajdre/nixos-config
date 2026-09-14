-- GENERAL

hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 15,

    border_size = 5,

    col = {
      active_border = { colors = { 'rgba(b3ff1aee)', 'rgba(ffffffff)' }, angle = 45 },
      inactive_border = 'rgba(745540ff)',
    },

    resize_on_border = false,

    allow_tearing = false,

    layout = 'master',
  },

  decoration = {
    rounding = 10,

    active_opacity = 1.0,
    inactive_opacity = 1.0,

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = 'rgba(1a1a1aee)',
    },

    blur = {
      enabled = true,
      size = 3,
      passes = 1,

      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },

  master = {
    new_status = 'slave',
    orientation = 'left',
    mfact = 0.5,
  },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
        disable_splash_rendering = true,
    },

    input = {
        kb_layout = 'pl',
        kb_variant = '',
        kb_model = '',
        kb_options = '',
        kb_rules = '',

        sensitivity = -0.15,
        accel_profile = 'flat',
        follow_mouse = 2,

        touchpad = {
            natural_scroll = true,
        },
    },

    cursor = {
        hide_on_key_press = true,
    },
})
