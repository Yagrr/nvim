return {
  {
    -- docs: https://github.com/goerz/jupytext.nvim?tab=readme-ov-file#options
    "goerz/jupytext.nvim",
    version = "0.2.0",
    opts = {
      format = "py:percent",
    },
  },

  {
    -- docs: https://mmngreco.dev/posts/vim-for-ml/#neovim-for-ml
    --  https://youtu.be/9PuF36UNOjM
    -- dependencies:
    -- a terminal that supports images (kitty)
    -- ipython
    -- plotly pdbpp
    "jpalardy/vim-slime",
    enabled = true,
    init = function()
      vim.g.slime_last_channel = { nil }
      -- Use `# %%` to define cells
      vim.g.slime_cell_delimiter = "\\s*#\\s*%%"

      -- Check if windows or linux since this workflow must use .slime_paste as buffer
      -- vim.loop.os_uname().sysname depreciated, now replaced with vim.uv
      if vim.uv.os_uname().sysname == "Windows_NT" then
        -- WINDOWS ONLY: setting undodir
        vim.g.slime_paste_file = os.getenv("USERPROFILE") .. "/.slime_paste"
      else
        vim.g.slime_paste_file = os.getenv("HOME") .. "/.slime_paste"
      end

      -- programme start
      local function next_cell()
        vim.fn.search(vim.g.slime_cell_delimiter)
      end

      local function prev_cell()
        vim.fn.search(vim.g.slime_cell_delimiter, "b")
      end

      local slime_get_jobid = function()
        local buffers = vim.api.nvim_list_bufs()
        local terminal_buffers = { "Select terminal:\tjobid\tname" }
        local name = ""
        local jid = 1
        local chosen_terminal = 1

        for _, buf in ipairs(buffers) do
          if vim.bo[buf].buftype == "terminal" then
            jid = vim.api.nvim_buf_get_var(buf, "terminal_job_id")
            name = vim.api.nvim_buf_get_name(buf)
            table.insert(terminal_buffers, jid .. "\t" .. name)
          end
        end

        -- if there is more than one terminal, ask which one to use
        if #terminal_buffers > 2 then
          chosen_terminal = vim.fn.inputlist(terminal_buffers)
        else
          chosen_terminal = jid
        end

        if chosen_terminal then
          print("\n[slime] jobid chosen: ", chosen_terminal)
          return chosen_terminal
        else
          print("No terminal found")
        end
      end

      local function slime_use_tmux()
        vim.b.slime_config = nil
        vim.g.slime_target = "tmux"
        vim.g.slime_bracketed_paste = 1
        vim.g.slime_python_ipython = 0
        vim.g.slime_no_mappings = 1
        -- Can check target_pane using tmux list-panes -a
        vim.g.slime_default_config = { socket_name = "default", target_pane = ":.2" }
        vim.g.slime_dont_ask_default = 1
      end

      local function slime_use_neovim()
        vim.b.slime_config = nil
        vim.g.slime_target = "neovim"
        vim.g.slime_bracketed_paste = 1
        vim.g.slime_python_ipython = 1
        vim.g.slime_no_mappings = 1
        vim.g.slime_get_jobid = slime_get_jobid
        -- vim.g.slime_default_config = nil
        -- vim.g.slime_dont_ask_default = 0
      end

      vim.api.nvim_create_user_command("SlimeTarget", function(opts)
        vim.b.slime_config = nil
        if opts.args == "tmux" then
          slime_use_tmux()
        elseif opts.args == "neovim" then
          slime_use_neovim()
        else
          vim.g.slime_target = opts.args
        end
      end, { desc = "Change Slime target", nargs = "*" })

      -- Keybinds
      -- Usage: Use SlimeConfig to initialise plugin
      vim.keymap.set("n", "<leader>ce", vim.cmd.SlimeSend, { noremap = true, desc = "send line to term" })
      vim.keymap.set("n", "<leader>cv", vim.cmd.SlimeConfig, { noremap = true, desc = "Open slime configuration" })
      vim.keymap.set("x", "<leader>cc", "<Plug>SlimeRegionSend", { noremap = true, desc = "send line to tmux" })
      vim.keymap.set(
        "n",
        "<leader>cep",
        "<Plug>SlimeParagraphSend",
        { noremap = true, desc = "Send Paragraph with Slime" }
      )
      vim.keymap.set(
        "n",
        "<leader>ck",
        prev_cell,
        { noremap = true, desc = "Search backward for slime cell delimiter" }
      )
      vim.keymap.set("n", "<leader>cj", next_cell, { noremap = true, desc = "Search forward for slime cell delimiter" })
      vim.keymap.set("n", "<leader>cc", "<Plug>SlimeSendCell", { noremap = true, desc = "Send cell to slime" })

      slime_use_neovim()
      -- slime_use_tmux()
      -- }}
    end,
  },
}
