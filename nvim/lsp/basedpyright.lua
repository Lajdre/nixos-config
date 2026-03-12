return {
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      analysis = {
        diagnosticSeverityOverrides = {
          reportUnusedVariable = 'hint',
          reportUnusedCallResult = false,
          reportAny = false,
          reportExplicitAny = false,
        },
      },
    },
  },
}
