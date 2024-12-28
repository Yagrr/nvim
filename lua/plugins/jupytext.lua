return {
  -- https://mmngreco.dev/posts/vim-for-ml/#neovim-for-ml
  {
    "goerz/jupytext.vim",
    enabled = true,
    init = function()
      -- will use `# %%` to define cells
      vim.g.jupytext_fmt = "py:percent"
    end,
  },
}
