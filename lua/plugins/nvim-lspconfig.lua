--  By default, Neovim supports a subset of the LSP specification.
--  With blink.cmp, Neovim has *more* capabilities which are communicated to the LSP servers.
-- LSP servers and clients communicate which features they support through "capabilities".
--  Explanation from TJ: https://youtu.be/m8C0Cq9Uv9o?t=1275
--
-- This can vary by config, but in general for nvim-lspconfig:
return {
  {
    "mason-org/mason-lspconfig.nvim",

    -- example using `opts` for defining servers
    -- :help lspconfig-all
    opts = {
      servers = {
        clangd = {},
        cmake = {},
        cssls = {},
        html = {},
        lua_ls = {},
        pyright = {},
        ruff = {},
      },
    },

    dependencies = {
      "mason-org/mason.nvim",
      "saghen/blink.cmp",
      "neovim/nvim-lspconfig",
    },

    config = function(_, opts)
      -- Setup Mason
      require("mason").setup()
      require("mason-lspconfig").setup()

      for server, config in pairs(opts.servers) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        vim.lsp.enable(server)
        if config then
          vim.lsp.config(server, config)
        end
      end
    end,
  },
}
