return {
  'asterikss/dev-chronicles.nvim',
  dir = '~/projects/dev-chronicles.nvim/master/',
  opts = {
    tracked_parent_dirs = { '~/projects/zzpackage/', '~/projects/' },
    tracked_dirs = { '~/nixos-config/' },
    exclude_subdirs_relative = { 'zzsilent/' },
    timeline = {
      timeline_days = {
        segment_abbr_labels = {
          date_abbrs = { 'nd', 'pn', 'wt', 'śr', 'cz', 'pt', 'sb' },
        },
      },
      timeline_months = {
        segment_abbr_labels = {
          date_abbrs = {
            'styczń',
            'luty',
            'marzec',
            'kwiecień',
            'maj',
            'czerwiec',
            'lipiec',
            'sierpień',
            'wrzesień',
            'paździer',
            'listopad',
            'grudzień',
          },
        },
      },
    },
  },
}
