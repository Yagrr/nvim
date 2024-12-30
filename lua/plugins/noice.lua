return {
  "folke/noice.nvim",
  opts = function(_, opts)
    opts.lsp.signature = {
      -- Height of LSP pop up was too big, setting it to 8 instead.
      opts = { size = { max_height = 8 } },
    }
  end,
}
