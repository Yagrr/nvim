return {
  {
    "benlubas/molten-nvim",
    enabled = false,
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- these are examples, not defaults. Please see the readme
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20

      -- Setting venv
      vim.g.python3_host_prog = vim.fn.expand("/home/sirtas/miniconda3/envs/ds-py/bin/python")

      -- Keybindings

      --vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize the plugin" })
      --vim.keymap.set(
      --  "n",
      --  "<localleader>me",
      --  ":MoltenEvaluateOperator<CR>",
      --  { silent = true, desc = "run operator selection" }
      --)
      --vim.keymap.set("n", "<localleader>ll", ":MoltenEvaluateLine<CR>", { silent = true, desc = "evaluate line" })
      --vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", { silent = true, desc = "re-evaluate cell" })
      --vim.keymap.set(
      --  "v",
      --  "<localleader>mr",
      --  ":<C-u>MoltenEvaluateVisual<CR>gv",
      --  { silent = true, desc = "evaluate visual selection" })
    end,
  },
  {
    -- see the image.nvim readme for more information about configuring this plugin
    "3rd/image.nvim",
    opts = {
      backend = "kitty", -- whatever backend you would like to use
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },
}