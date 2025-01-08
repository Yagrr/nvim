local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

if is_windows then
  --Windows specific settings
  local win_prefer_git = false
end

return {
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- Automatically install missing parsers
      auto_install = true,
      indent = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      prefer_git = win_prefer_git,
      compilers = { "zig", "gcc", "clang", "cc", "cl" },

      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },
}

-- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
-- would overwrite `ensure_installed` with the new value.
-- If you'd rather extend the default config, use the code below instead:
--[[
{
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },
}
]]
--
