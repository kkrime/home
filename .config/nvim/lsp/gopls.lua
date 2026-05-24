return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.mod", "go.work", "doc.go", ".git" },
  settings = {
    gopls = {
      -- buildFlags = { "-tags=integration some-other-tags..." },
      -- experimentalWorkspaceModule = true,
      -- expandWorkspaceToModule = true,
      completeUnimported = true,
      usePlaceholders = false,
      analyses = {
        unusedparams = true,
      },
      -- ["build.experimentalWorkspaceModule"] = true,
      ["formatting.gofumpt"] = true,
      ["staticcheck"] = true,
      ["ui.verboseOutput"] = true,
    },
  },
}
