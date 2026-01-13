-- INSTALLATION SUMMARY
-- ====================================
-- 1. Create init.lua file:
-- mkdir /.config/nvim
-- touch init.lua
--
-- 2. Downloand and configure Lua and LuaRocks (package manager)
-- sudo apt install lua5.3 liblua5.3-dev
-- tar -xzvf luarocks.tar.gz
-- ./configure --with-lua-include=/usr/local/include --with-lua-bin=/usr/bin --lua-version=5.3
--
--3. Install `stylelua` (optional) Lua code formatter

-- NOTES
-- ====================================
-- lazy.nvim is a package manager for installing plugins. Other package managers include `Packer`, `Paq` and `vim-plug`.
-- Mason is a tool manager for LSP, DAP, linters and formatters.
-- It installs external executables—LSP servers, DAP adapters, linters/formatters—so you don’t have to manage them with pip or npm yourself.
-- Mason does include many popular formatters (e.g. black, prettier, stylua) so you can often install them via :MasonInstall <formatter>.
-- Some formatters not in Mason’s registry (or if you prefer a specific version) you’ll indeed install manually (e.g. pip install autopep8) and then point Mason (or your Conform/null-ls config) at the binary path.

-- COMMANDS
-- ====================================
-- `:Lazy update` - pulls the latest versions of your already-installed plugins
-- `:Lazy sync` - install plugins added/deleted from init.lua and update current plugins (same as `:Lazy update`)
--
--
--
-- `:stylelua --version` - checks stylelua version
-- `:lua print(vim.inspect(require("mason-lspconfig").get_available_servers()))` - checks available lsp servers in Mason
-- `:!autopep8 ~/Downloads/main.py --in-place` - formats the Python file manually

-- CUSTOM MAPPINGS
-- ====================================

-- BOOTSTRAP LAZY.NVIM
-- ====================================
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- BOOTSTRAP LAZY.NVIM
--
--
--
--
--
--
vim.opt.wrap = false
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set('x', 'p', '"_dP', { desc = 'Visual paste (keep yank)' })
vim.keymap.set('x', 'P', '"_dP', { desc = 'Visual paste (keep yank)' })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "dart",
    callback = function()
        -- Use vim.opt_local to set these options for the current buffer only
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt.autoindent = true
        vim.opt.smartindent = true

    end,
    desc = "Set buffer-local indentation for Dart files",
})


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo(
            {
                {"Failed to clone lazy.nvim:\n", "ErrorMsg"},
                {out, "WarningMsg"},
                {"\nPress any key to exit..."}
            },
            true,
            {}
        )
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)
vim.opt.termguicolors = true

-- Basic vim options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.signcolumn = "yes" 


local o = vim.opt
o.swapfile   = false
o.backup     = false
o.writebackup = false

-- CLIPBOARD INTEGRATION: Yank saves to system clipboard
vim.opt.clipboard = "unnamedplus"
-- Additional clipboard settings for better compatibility on Ubuntu
if vim.fn.has("unix") == 1 then
    if vim.fn.executable("xclip") == 1 then
        vim.g.clipboard = {
            name = "xclip",
            copy = {
                ["+"] = "xclip -selection clipboard",
                ["*"] = "xclip -selection primary",
            },
            paste = {
                ["+"] = "xclip -selection clipboard -o",
                ["*"] = "xclip -selection primary -o",
            },
            cache_enabled = 0,  -- Disable caching to prevent multiple xclip processes
        }
    elseif vim.fn.executable("xsel") == 1 then
        vim.g.clipboard = {
            name = "xsel",
            copy = {
                ["+"] = "xsel --clipboard --input",
                ["*"] = "xsel --primary --input",
            },
            paste = {
                ["+"] = "xsel --clipboard --output",
                ["*"] = "xsel --primary --output",
            },
            cache_enabled = 0,  -- Disable caching
        }
    end
end

-- LSP diagnostic configuration - Only show errors, hide warnings
vim.diagnostic.config({
    virtual_text = {
        severity = vim.diagnostic.severity.ERROR,
    },
    signs = {
        severity = vim.diagnostic.severity.ERROR,
    },
    underline = {
        severity = vim.diagnostic.severity.ERROR,
    },
    float = {
        severity = vim.diagnostic.severity.ERROR,
    },
})

-- Key mappings
vim.keymap.set("n", "<C-h>", "<C-w>h", {desc = "Go to left window"})
vim.keymap.set("n", "<C-j>", "<C-w>j", {desc = "Go to bottom window"})
vim.keymap.set("n", "<C-k>", "<C-w>k", {desc = "Go to top window"})
vim.keymap.set("n", "<C-l>", "<C-w>l", {desc = "Go to right window"})
vim.keymap.set({"n", "i"}, "<C-s>", "<Cmd>w<CR>", {desc = "Save file", silent = true})



vim.keymap.set("n", "<leader>yf", function()
  local file_path = vim.fn.expand("%:p")
  if file_path ~= "" then
    vim.fn.setreg("+", file_path)
    vim.notify("Copied file path: " .. file_path)
  else
    vim.notify("No file path to copy", vim.log.levels.WARN)
  end
end, {desc = "Copy full file path to clipboard"})






-- vim.keymap.set("n", "ep", vim.diagnostic.goto_prev, {desc = "Previous LSP diagnostic"})
-- vim.keymap.set("n", "en", vim.diagnostic.goto_next, {desc = "Next LSP diagnostic"})
--
--
--

-- Paste with automatic indentation
-- vim.keymap.set("n", "<leader>p", "p==", {desc = "Paste before cursor with auto-indent"})
-- vim.keymap.set("n", "<leader>P", "P==", {desc = "Paste before cursor with auto-indent"})

-- We took this one out for now 
-- vim.keymap.set("n", "ep", function()
--     vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
-- end, {desc = "Previous LSP error"})
--
-- vim.keymap.set("n", "en", function()
--     vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
-- end, {desc = "Next LSP error"})
--
--
--
--
--
--

-- Highlight pasted text
-- vim.keymap.set("n", "p", function()
--     vim.cmd("normal! p")
--     vim.cmd("normal! `[v`]")
-- end, {desc = "Paste and select"})
--
-- vim.keymap.set("n", "P", function()
--     vim.cmd("normal! P")
--     vim.cmd("normal! `[v`]")
-- end, {desc = "Paste before and select"})
--


---- Terminal shortcuts
-- vim.keymap.set("n", "<leader>T", function()
--     local current_dir = vim.fn.expand("%:p:h")
--     vim.cmd("split | terminal")
--     vim.cmd("cd " .. current_dir)
-- end, {desc = "Open terminal in current file's directory"})

-- vim.keymap.set("n", "<leader>t", function()
--     local current_dir = vim.fn.expand("%:p:h")
--     vim.cmd("vsplit | terminal")
--     vim.cmd("cd " .. current_dir)
-- end, {desc = "Open terminal vertically in current file's directory"})

-- -- For tmux users - open external terminal with tmux
-- vim.keymap.set("n", "<leader>tm", function()
--     local current_dir = vim.fn.expand("%:p:h")
--     vim.fn.system("tmux new-window -c '" .. current_dir .. "'")
--
---- Force fresh directory behavior - add this near the top of your init.lua after basic options








--
-- Terminal configuration
-- Terminal configuration
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        -- Enter insert mode automatically
        vim.cmd("startinsert")
        -- Set local options for terminal buffers
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.scrolloff = 0

        -- Easy escape from terminal mode
        vim.keymap.set("t", "<Esc>", function()
            vim.cmd("stopinsert")
            vim.opt_local.modifiable = true  -- Make buffer modifiable in normal mode
        end, {buffer = true, desc = "Exit terminal mode"})

        vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", {buffer = true, desc = "Go to left window"})
        vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", {buffer = true, desc = "Go to bottom window"})
        vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", {buffer = true, desc = "Go to top window"})
        vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", {buffer = true, desc = "Go to right window"})

    end,
})


-- NEW FEATURE: Yank current error virtual text to clipboard with <leader>ey
vim.keymap.set("n", "<leader>ey", function()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local row = cursor_pos[1] - 1  -- Convert to 0-based indexing

    -- Get diagnostics for current buffer at cursor position
    local diagnostics = vim.diagnostic.get(0, {
        lnum = row,
        severity = vim.diagnostic.severity.ERROR
    })

    -- If no error at cursor, get the nearest error in the buffer
    if #diagnostics == 0 then
        local all_errors = vim.diagnostic.get(0, {
            severity = vim.diagnostic.severity.ERROR
        })

        if #all_errors == 0 then
            vim.notify("No errors found in current buffer", vim.log.levels.WARN)
            return
        end

        -- Find the nearest error to cursor position
        local nearest_error = nil
        local min_distance = math.huge

        for _, diagnostic in ipairs(all_errors) do
            local distance = math.abs(diagnostic.lnum - row)
            if distance < min_distance then
                min_distance = distance
                nearest_error = diagnostic
            end
        end

        diagnostics = {nearest_error}
    end

    if #diagnostics > 0 then
        local error = diagnostics[1]
        -- Just get the raw error message (what appears in virtual text)
        local error_message = error.message

        -- Copy to clipboard
        vim.fn.setreg("+", error_message)
        vim.fn.setreg("*", error_message)  -- Also copy to primary selection

        -- Show confirmation with truncated message
        local display_msg = error_message:sub(1, 60) .. (error_message:len() > 60 and "..." or "")
        vim.notify("Error copied to clipboard: " .. display_msg, vim.log.levels.INFO)
    else
        vim.notify("No error found at cursor position", vim.log.levels.WARN)
    end
end, {desc = "Yank current error to clipboard"})




-- Toggle a dedicated terminal for Claude Code with <leader>c
--
--
--
--
--
--
vim.keymap.set("n", "<leader>c", function()
    -- Define a specific buffer name for the Claude Code terminal
    local claude_buf_name = "claude_code_terminal"
    local claude_buf_nr = vim.fn.bufnr(claude_buf_name)

    -- Check if the Claude Code terminal buffer exists
    if claude_buf_nr ~= -1 then
        local win_found = false
        -- Check if the window is already visible
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_buf(win) == claude_buf_nr then
                -- If it's visible, hide it
                vim.api.nvim_win_close(win, false)
                win_found = true
                break
            end
        end

        -- If the buffer exists but the window was not found, open it
        if not win_found then
            vim.cmd("vsplit")
            vim.api.nvim_win_set_buf(0, claude_buf_nr)
            vim.cmd("vertical resize 60")
            -- We enter terminal mode automatically, no 'startinsert' needed
        end
        return
    end

    -- If the buffer doesn't exist, create a new terminal for Claude Code
    vim.cmd("vsplit")
    vim.cmd("vertical resize 60")
    vim.cmd("term claude")
    vim.api.nvim_buf_set_name(0, claude_buf_name)
    vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { buffer = true, desc = "Exit terminal mode" })

end, { desc = "Toggle Claude Code terminal" })






-- Single terminal toggle with <leader>t
vim.keymap.set("n", "<leader>t", function()
    -- If terminal is visible, hide it
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.api.nvim_buf_get_option(buf, "buftype") == "terminal" then
            vim.api.nvim_win_close(win, false)
            return
        end
    end

    -- Always create a new terminal in current directory
    local current_dir = vim.fn.expand("%:p:h")
    -- vim.cmd("split")
    vim.cmd("botright split")

    vim.cmd("terminal")
    vim.cmd("resize 10")

    -- Send cd command to the new terminal
    local job_id = vim.b.terminal_job_id
    if job_id then
        vim.api.nvim_chan_send(job_id, "cd " .. vim.fn.shellescape(current_dir) .. "\r")
    end
end, {desc = "Toggle terminal"})

-- Clear search highlights and ensure ESC behaves normally
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", {desc = "Clear search highlights", silent = true})

-- File tree toggle
vim.keymap.set(
    "n",
    "<leader>w",
    function()
        require("nvim-tree.api").tree.toggle({
            find_file = true,
            focus = true

        })
    end,
    {desc = "Toggle File Explorer"}
)

vim.keymap.set("n", "<leader>e", function()
    require("telescope.builtin").diagnostics({
        severity = vim.diagnostic.severity.ERROR,
        bufnr = 0,  -- Only current buffer
        prompt_title = "Errors in Current Buffer",
    })
end, {desc = "Show errors in current buffer"})


-- Optional: Add this for project-wide errors
vim.keymap.set("n", "<leader>E", function()
    require("telescope.builtin").diagnostics({
        severity = vim.diagnostic.severity.ERROR,
        prompt_title = "Errors in Project",
        -- Add these options to filter out virtual environment files
        file_ignore_patterns = {
            "%.venv/.*",
            "venv/.*", 
            "env/.*",
            "%.env/.*",
            "node_modules/.*",
            "site%-packages/.*",
            "%.git/.*"
        },
        -- Only show files in current working directory tree
        cwd = vim.fn.getcwd(),
    })
end, {desc = "Show errors in project"})






-- Toggle hints/warnings visibility in buffer
vim.keymap.set("n", "<leader>h", function()
    local current_config = vim.diagnostic.config()
    local current_severities = current_config.virtual_text.severity

    -- Check if we're currently showing only errors
    if type(current_severities) == "number" and current_severities == vim.diagnostic.severity.ERROR then
        -- hints
        vim.diagnostic.config({
            virtual_text = {
                severity = {  vim.diagnostic.severity.HINT },
            },
            signs = {
                severity = {  vim.diagnostic.severity.HINT },
            },
            underline = {
                severity = {  vim.diagnostic.severity.HINT },
            },
            float = {
                severity = {  vim.diagnostic.severity.HINT },
            },
        })
        vim.notify("Showing errors + hints", vim.log.levels.INFO)
    else
        -- Back to errors only
        vim.diagnostic.config({
            virtual_text = {
                severity = vim.diagnostic.severity.ERROR,
            },
            signs = {
                severity = vim.diagnostic.severity.ERROR,
            },
            underline = {
                severity = vim.diagnostic.severity.ERROR,
            },
            float = {
                severity = vim.diagnostic.severity.ERROR,
            },
        })
        vim.notify("Showing errors only", vim.log.levels.INFO)
    end
end, {desc = "Toggle hints visibility in buffer"})


-- -- Unused code in current buffer
-- vim.keymap.set("n", "<leader>h", function()
--     require("telescope.builtin").diagnostics({
--         severity = vim.diagnostic.severity.HINT,
--         bufnr = 0,
--         prompt_title = "Unused Code in Current Buffer",
--     })
-- end, {desc = "Show unused code/imports in current buffer"})



-- Unused code project-wide
vim.keymap.set("n", "<leader>H", function()
    require("telescope.builtin").diagnostics({
        severity = vim.diagnostic.severity.HINT,
        prompt_title = "Unused Code in Project",
        -- Filter out virtual environment files
        file_ignore_patterns = {
            "%.venv/.*",
            "venv/.*", 
            "env/.*",
            "%.env/.*",
            "node_modules/.*",
            "site%-packages/.*",
            "%.git/.*"
        },
        cwd = vim.fn.getcwd(),
    })
end, {desc = "Show unused code/imports in project"})



-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- NORD THEME - Load first with highest priority
        {
            -- 'AlexvZyl/nordic.nvim',
            "rebelot/kanagawa.nvim",
            -- "shaunsingh/nord.nvim",
            lazy = false,
            priority = 1000,
            config = function()
                -- Configure Nord before loading
                -- vim.g.nord_contrast = true
                -- vim.g.nord_borders = false
                -- vim.g.nord_disable_background = false
                -- vim.g.nord_italic = false
                -- vim.g.nord_uniform_diff_background = true
                -- vim.g.nord_bold = false

                --
                --
                vim.cmd([[colorscheme kanagawa-dragon]])
                -- vim.cmd([[colorscheme nord]])
                -- require('nordic').load()
            end
        },

        -- Icons (load early)
        {
            "nvim-tree/nvim-web-devicons",
            config = function()
                require("nvim-web-devicons").setup {
                    default = true
                }
            end
        },

        -- Telescope
        {
            "nvim-telescope/telescope.nvim",
            dependencies = {"nvim-lua/plenary.nvim"},
            config = function()
                local builtin = require("telescope.builtin")
                local actions = require("telescope.actions")

                -- Configure telescope with recent files prioritized
                require("telescope").setup({
                    defaults = {
                        file_sorter = require("telescope.sorters").get_fuzzy_file,
                        file_ignore_patterns = {
                            "node_modules",
                            ".git/",
                            "dist/",
                            "build/",
                            "__pycache__/",
                            "*.pyc"
                        },
                        mappings = {
                            i = {
                                ["<C-q>"] = actions.send_selected_to_qflist,
                            },
                            n = {
                                ["<C-q>"] = actions.send_selected_to_qflist,
                            },
                        },
                    },

                    pickers = {
                        find_files = {
                            -- Show hidden files but respect .gitignore
                            hidden = true,
                            -- Sort by recent usage
                            sorter = require("telescope.sorters").get_fzy_sorter(),
                        },
                    },
                })

                -- Space Space: Recent files (oldfiles) - most recently used first
                vim.keymap.set("n", "<leader><leader>", function()
                    builtin.oldfiles({
                        prompt_title = "Recent Files",
                        only_cwd = true,  -- Only show files from current working directory
                    })
                end, {desc = "Recent files"})

                -- Leader f: All files in project
                vim.keymap.set("n", "<leader>f", builtin.find_files, {desc = "Find all files"})
                vim.keymap.set("n", "<leader>s", builtin.live_grep, {desc = "Live grep"})

                vim.keymap.set("n", "<leader>q", function()
                    -- Find a suitable window that's not NvimTree
                    local current_win = vim.api.nvim_get_current_win()
                    local wins = vim.api.nvim_list_wins()

                    for _, win in ipairs(wins) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        local ft = vim.api.nvim_buf_get_option(buf, "filetype")

                        -- Switch to the first non-special window (not NvimTree, not terminal, etc.)
                        if ft ~= "NvimTree" and ft ~= "TelescopePrompt" and vim.api.nvim_buf_get_option(buf, "buftype") ~= "terminal" then
                            vim.api.nvim_set_current_win(win)
                            break
                        end
                    end

                    builtin.quickfix({
                        prompt_title = "Quickfix List",
                        show_line = true,
                        trim_text = true,
                    })
                end, {desc = "View quickfix list in Telescope"})

            end
        },

        -- File tree
        {
            "nvim-tree/nvim-tree.lua",
            dependencies = {"nvim-tree/nvim-web-devicons"},
            config = function()
                require("nvim-tree").setup({
                    view = {width = 40, side = "left", adaptive_size = false},
                    renderer = {group_empty = true},
                    filters = {dotfiles = false},
                    -- Enable folding in file tree
                    actions = {
                        open_file = {
                            quit_on_open = false,
                            resize_window = true,
                        },
                    },
                })

                -- Add fold keymaps for file tree
                vim.api.nvim_create_autocmd("FileType", {
                    pattern = "NvimTree",
                    callback = function()
                        local api = require("nvim-tree.api")
                        -- Map h/l for collapse/expand in tree
                        vim.keymap.set("n", "h", function() api.node.navigate.parent_close() end, {buffer = true, desc = "Close folder"})
                        vim.keymap.set("n", "l", function() api.node.open.edit() end, {buffer = true, desc = "Open folder/file"})
                        -- Additional fold-like bindings
                        vim.keymap.set("n", "zo", function() api.node.open.edit() end, {buffer = true, desc = "Open folder"})
                        vim.keymap.set("n", "zc", function() api.node.navigate.parent_close() end, {buffer = true, desc = "Close folder"})
                        vim.keymap.set("n", "za", function() api.node.open.toggle() end, {buffer = true, desc = "Toggle folder"})
                        vim.keymap.set("n", "zM", function() api.tree.collapse_all() end, {buffer = true, desc = "Collapse all folders"})
                        vim.keymap.set("n", "zR", function() api.tree.expand_all() end, {buffer = true, desc = "Expand all folders"})

                    end,
                })
            end
        },

        -- Mason
        {
            "williamboman/mason.nvim",
            config = function()
                require("mason").setup()
            end
        },

        -- Mason-LSPConfig
        {
            "williamboman/mason-lspconfig.nvim",
            dependencies = {"williamboman/mason.nvim", "neovim/nvim-lspconfig"},
            config = function()
                require("mason-lspconfig").setup({
                    ensure_installed = {
                        "pyright",           -- Python
                        "html",              -- HTML
                        "cssls",             -- CSS
                        "ts_ls",             -- TypeScript/JavaScript
                        "gopls",             -- Go
                        "eslint",            -- JavaScript/TypeScript linting
                        "dartls",           -- Dart
                    }
                })
            end
        },















        -- Friendly snippets collection
        {
            "rafamadriz/friendly-snippets",
        },
        -- LSP Kind for pictograms
        {
            "onsails/lspkind.nvim",
        },
        {
            "hrsh7th/cmp-nvim-lua",
        },



        -- {
        --   "github/copilot.vim",
        --   event = "InsertEnter",
        -- },


        -- {
        --   "github/copilot.vim",
        --   event = "InsertEnter",
        -- },




        {
          "github/copilot.vim",
          lazy = false,                  -- ← was event = "InsertEnter"
          config = function()
            vim.cmd("silent! Copilot enable")
          end,
        },




        -- {
        --   "github/copilot.vim",
        --   event = "InsertEnter",
        --   -- config = function()
        --   --   -- <Space>a  → request suggestion now
        --   --   vim.keymap.set("i", "<leader>a",  "<Plug>(copilot-suggest)",  { silent = true, desc = "Copilot: suggest" })
        --   --   -- <Space>an → next suggestion
        --   --   vim.keymap.set("i", "<leader>an", "<Plug>(copilot-next)",     { silent = true, desc = "Copilot: next" })
        --   --   -- <Space>ap → previous suggestion
        --   --   vim.keymap.set("i", "<leader>ap", "<Plug>(copilot-previous)", { silent = true, desc = "Copilot: prev" })
        --   -- end,
        -- },




        {
            "hrsh7th/cmp-emoji",
        },
        {
            "hrsh7th/cmp-calc",
        },

        -- Snippet engine
        { "dcampos/nvim-snippy" },
        { "dcampos/cmp-snippy", dependencies = { "dcampos/nvim-snippy" } },

        -- Completion (VSCode-like UI, LSP -> Snippets -> Path/Buffer)
        {
            "hrsh7th/nvim-cmp",
            event = "InsertEnter",
            dependencies = {
                "dcampos/cmp-snippy",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "onsails/lspkind.nvim",
            },
            config = function()
                local cmp     = require("cmp")
                local snippy  = require("snippy")
                local lspkind = require("lspkind")

                -- VSCode-like visuals
                local kind_fmt = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = 50,
                    ellipsis_char = "…",
                    menu = { nvim_lsp = "[LSP]", snippy = "[Snip]", path = "[Path]", buffer = "[Buf]" },
                })

                -- Pragmatic filtering
                local function is_member_ctx(ctx)
                    -- e.g. "obj." , "obj.ab"  → we’re after a dot near the cursor
                    return ctx.cursor_before_line:find("%.[%w_]*$") ~= nil
                end
                local function typed_prefix(ctx)
                    return (ctx.cursor_before_line:match("[_%w]+$")) or ""
                end

                -- LSP entry filter: drop spam
                local function lsp_entry_filter(entry, ctx)
                    local kind  = entry:get_kind()
                    local label = entry.completion_item and entry.completion_item.label or ""
                    local pref  = typed_prefix(ctx)

                    -- 1) never show Keywords
                    if kind == cmp.lsp.CompletionItemKind.Keyword then
                        return false
                    end

                    -- 2) hide private/dunder unless user explicitly types "_"
                    if not pref:match("^_") then
                        if label:match("^__.*__$") or label:match("^_") then
                            return false
                        end
                    end

                    -- 3) in member access, keep it tight: no classes/modules/enums/etc.
                    if is_member_ctx(ctx) then
                        local allow = {
                            [cmp.lsp.CompletionItemKind.Variable] = true,
                            [cmp.lsp.CompletionItemKind.Field]    = true,
                            [cmp.lsp.CompletionItemKind.Property] = true,
                            [cmp.lsp.CompletionItemKind.Method]   = true,
                            [cmp.lsp.CompletionItemKind.Function] = true, -- some servers mark props as funcs
                            [cmp.lsp.CompletionItemKind.Constant] = true,
                        }
                        if not allow[kind] then return false end
                    end

                    return true
                end

                -- Prefer Variables, then Field/Property, then Methods
                local KIND_PRIO = {
                    [cmp.lsp.CompletionItemKind.Variable] = 10,
                    [cmp.lsp.CompletionItemKind.Field]    = 20,
                    [cmp.lsp.CompletionItemKind.Property] = 25,
                    [cmp.lsp.CompletionItemKind.Constant] = 30,
                    [cmp.lsp.CompletionItemKind.Function] = 40,
                    [cmp.lsp.CompletionItemKind.Method]   = 50,
                    -- everything else lower priority (bigger number)
                }
                local function by_kind_priority(a, b)
                    local ka = KIND_PRIO[a:get_kind()] or 1000
                    local kb = KIND_PRIO[b:get_kind()] or 1000
                    if ka ~= kb then return ka < kb end
                end

                snippy.setup({
                    mappings = {},                                       -- no Tab bindings
                    snippet_dirs = { vim.fn.stdpath("config") .. "/snippets" },
                })

                vim.opt.completeopt = { "menu", "menuone", "noselect" }

                cmp.setup({
                    snippet = { expand = function(a) snippy.expand_snippet(a.body) end },

                    completion = {
                        -- autocomplete = false,                     -- no auto popup
                        autocomplete = { cmp.TriggerEvent.InsertEnter, cmp.TriggerEvent.TextChanged },
                        keyword_length = 1,
                    },

                    matching = {                                         -- reduce fuzzy spam
                        disallow_fuzzy_matching = true,
                        disallow_partial_fuzzy_matching = true,
                        disallow_prefix_unmatching = true,
                    },

                    window = {
                        completion = cmp.config.window.bordered(),
                        documentation = cmp.config.window.bordered(),
                    },
                    formatting = {
                        fields = { "kind", "abbr", "menu" },
                        format = kind_fmt,
                    },

                    preselect = cmp.PreselectMode.Item,

                    mapping = {
                        ["<C-y>"]     = cmp.mapping.confirm({ select = true }), -- ONLY Ctrl+Y confirms
                        ["<CR>"]      = cmp.config.disable,                     -- Enter won’t confirm
                        ["<C-e>"]     = cmp.mapping.abort(),
                        ["<C-n>"]     = cmp.mapping.select_next_item(),
                        ["<C-p>"]     = cmp.mapping.select_prev_item(),
                        ["<C-Space>"] = cmp.mapping.complete(),
                        ["<Tab>"]     = cmp.config.disable,                     -- keep Tab for Copilot
                        ["<S-Tab>"]   = cmp.config.disable,
                    },

                    -- Order: LSP → Snippets → Path → Buffer (buffer limited)
                    sources = {
                        { name = "nvim_lsp", entry_filter = lsp_entry_filter, max_item_count = 25 },
                        { name = "snippy" },
                        { name = "path" },
                        { name = "buffer", keyword_length = 4, max_item_count = 5 },
                    },

                    sorting = {
                        comparators = {
                            by_kind_priority,                 -- our custom kind order
                            cmp.config.compare.exact,
                            cmp.config.compare.score,
                            cmp.config.compare.recently_used,
                            cmp.config.compare.sort_text,
                            cmp.config.compare.length,
                            cmp.config.compare.order,
                        },
                    },
                })
            end,
        },




        -- Additional completion sources
        {
            "neovim/nvim-lspconfig",
            dependencies = {"hrsh7th/cmp-nvim-lsp"},
            config = function()
                local lspconfig = require("lspconfig")
                local cmp_nvim_lsp = require("cmp_nvim_lsp")

                -- Enhanced capabilities for completion
                local capabilities = cmp_nvim_lsp.default_capabilities()
                capabilities.textDocument.completion.completionItem.snippetSupport = true
                capabilities.textDocument.completion.completionItem.resolveSupport = {
                    properties = {
                        'documentation',
                        'detail',
                        'additionalTextEdits',
                    }
                }


                -- Save all files after any LSP rename applies edits
                -- local orig_rename = vim.lsp.handlers["textDocument/rename"]
                -- vim.lsp.handlers["textDocument/rename"] = function(err, result, ctx, conf)
                --     local ret = orig_rename and orig_rename(err, result, ctx, conf)
                --     if not err and result and (result.changes or result.documentChanges) then
                --         vim.schedule(function()
                --             pcall(vim.cmd, "silent! wa")  -- let BufWritePre hooks run (eslint, formatters, etc.)
                --         end)
                --     end
                --     return ret
                -- end


                local on_attach = function(client, bufnr)
                    local bufmap = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, {buffer = bufnr, desc = desc})
                    end

                    -- bufmap("n", "gd", vim.lsp.buf.definition, "LSP: Go to Definition")
                    bufmap("n", "K", vim.lsp.buf.hover, "LSP: Hover Documentation")

                    -- bufmap("n", "gd", function()
                    --   tb.lsp_definitions({
                    --     show_line = true,   -- preview the line like your quickfix picker
                    --     trim_text = true,   -- cleaner display
                    --     -- jump_type = "never", -- uncomment if you ever see auto-jumps (rare)
                    --   })
                    -- end, "LSP: Definitions (Telescope)")
                    --
                    --
                    --
                    bufmap("n", "gd", function()
                      require("telescope.builtin").lsp_definitions{
                        show_line = true,
                        trim_text = true,
                        -- jump_type = "never",
                      }
                    end, "LSP: Definitions (Telescope)")
                    --
                    --

                    bufmap("n", "gD", function()
                      vim.lsp.buf.definition()
                      vim.defer_fn(function()
                        if #vim.fn.getqflist() > 1 then vim.cmd("copen") end
                      end, 0)
                    end, "LSP: Go to Definition (native)")


                    bufmap("n", "gr", function()
                        require("telescope.builtin").lsp_references({
                            include_declaration = false,
                            show_line = true,
                            trim_text = false,
                        })
                    end, "LSP: Show References in Telescope")

                    -- bufmap("n", "gca", vim.lsp.buf.code_action, "LSP: Code Action")
                    bufmap("n", "gs", vim.lsp.buf.rename, "LSP: Rename Symbol")
                end

                -- Python with enhanced settings
                lspconfig.pyright.setup {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    settings = {
                        python = {
                            analysis = {
                                typeCheckingMode = "basic",
                                diagnosticMode = "workspace",
                                autoSearchPaths = true,
                                useLibraryCodeForTypes = true,
                                autoImportCompletions = false,
                            }
                        }
                    }
                }

                -- HTML with enhanced completion
                lspconfig.html.setup {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    settings = {
                        html = {
                            suggest = {
                                html5 = true,
                            },
                            hover = {
                                documentation = true,
                                references = true,
                            },
                        }
                    }
                }

                -- CSS with enhanced completion
                lspconfig.cssls.setup {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    settings = {
                        css = {
                            suggest = {
                                unknownVendorSpecificProperties = "ignore"
                            },
                        },
                        less = {
                            suggest = {
                                unknownVendorSpecificProperties = "ignore"
                            },
                        },
                        scss = {
                            suggest = {
                                unknownVendorSpecificProperties = "ignore"
                            },
                        },
                    }
                }

                -- TypeScript/JavaScript with enhanced completion
                lspconfig.ts_ls.setup {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    settings = {
                        typescript = {
                            inlayHints = {
                                includeInlayParameterNameHints = "all",
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            },
                            suggest = {
                                includeCompletionsForModuleExports = true,
                                includeAutomaticOptionalChainCompletions = true,
                            }
                        },
                        javascript = {
                            inlayHints = {
                                includeInlayParameterNameHints = "all",
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            },
                            suggest = {
                                includeCompletionsForModuleExports = true,
                                includeAutomaticOptionalChainCompletions = true,
                            }
                        }
                    }
                }

                -- Go with enhanced completion
                lspconfig.gopls.setup {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    settings = {
                        gopls = {
                            analyses = {
                                unusedparams = true,
                            },
                            staticcheck = true,
                            gofumpt = true,
                            completeUnimported = true,
                            usePlaceholders = true,
                            matcher = "Fuzzy",
                        },
                    },
                }

                -- ESLint for JavaScript/TypeScript linting
                lspconfig.eslint.setup {
                    on_attach = function(client, bufnr)
                        -- Only show errors, not warnings
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            command = "EslintFixAll",
                        })
                        on_attach(client, bufnr)
                    end,
                    capabilities = capabilities,
                }


                -- Dart/Flutter with enhanced completion and Flutter-specific settings
                lspconfig.dartls.setup {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    settings = {
                        dart = {
                            -- These are helpful Flutter-specific features
                            flutterOutline = true,
                            showClosingLabels = true,

                            -- This is the path we found earlier
                            sdkPath = "/home/mc/Development/flutter/bin/cache/dart-sdk",
                        }
                    }
                }

            end
        },




















        -- Git signs
        {
            "lewis6991/gitsigns.nvim",
            config = function()
                require("gitsigns").setup {
                    signs = {},
                    on_attach = function(bufnr)
                        local gs = package.loaded.gitsigns
                        vim.keymap.set("n", "<leader>z", function()
                            gs.diffthis()
                        end, {buffer = bufnr, desc = "Git diff this buffer"})
                    end
                }
            end
        },

        -- Surround text objects (ci{, ca", ds(, ys, etc.)
        {
            "kylechui/nvim-surround",
            version = "*", -- Use for stability; omit to use `main` branch for the latest features
            event = "VeryLazy",
            config = function()
                require("nvim-surround").setup({
                    -- Configuration here, or leave empty to use defaults
                    keymaps = {
                        insert = "<C-g>s",
                        insert_line = "<C-g>S",
                        normal = "ys",
                        normal_cur = "yss",
                        normal_line = "yS",
                        normal_cur_line = "ySS",
                        visual = "S",
                        visual_line = "gS",
                        delete = "ds",
                        change = "cs",
                        change_line = "cS",
                    },
                })
            end,
        },

        -- Treesitter for syntax highlighting and text objects
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                require("nvim-treesitter.configs").setup({
                    ensure_installed = {
                        "python", "javascript", "typescript", "html", "css", 
                        "go", "lua", "json", "yaml", "markdown", "dart",
                    },
                    highlight = {
                        enable = true,
                    },
                    indent = {
                        enable = true,
                    },
                })
            end,
        },

        -- Treesitter text objects for arguments, functions, etc.
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            dependencies = {"nvim-treesitter/nvim-treesitter"},
            config = function()
                require("nvim-treesitter.configs").setup({
                    textobjects = {
                        select = {
                            enable = true,
                            lookahead = true, -- Automatically jump forward to textobj
                            keymaps = {
                                -- Arguments
                                ["aa"] = "@parameter.outer",  -- around argument
                                ["ia"] = "@parameter.inner",  -- inside argument

                                -- Functions
                                ["af"] = "@function.outer",   -- around function
                                ["if"] = "@function.inner",   -- inside function

                                -- Classes
                                ["ac"] = "@class.outer",      -- around class
                                ["ic"] = "@class.inner",      -- inside class

                                -- Conditionals (if statements)
                                ["ai"] = "@conditional.outer", -- around if
                                ["ii"] = "@conditional.inner", -- inside if

                                -- Loops
                                ["al"] = "@loop.outer",       -- around loop
                                ["il"] = "@loop.inner",       -- inside loop

                                -- Comments
                                ["a/"] = "@comment.outer",    -- around comment
                                ["i/"] = "@comment.inner",    -- inside comment
                            },
                        },
                        move = {
                            enable = true,
                            set_jumps = true, -- whether to set jumps in the jumplist
                            goto_next_start = {
                                ["]f"] = "@function.outer",
                                ["]c"] = "@class.outer",
                                ["]a"] = "@parameter.outer",
                                ["]l"] = "@loop.outer",
                            },
                            goto_next_end = {
                                ["]F"] = "@function.outer",
                                ["]C"] = "@class.outer",
                                ["]A"] = "@parameter.outer",
                                ["]L"] = "@loop.outer",
                            },
                            goto_previous_start = {
                                ["[f"] = "@function.outer",
                                ["[c"] = "@class.outer",
                                ["[a"] = "@parameter.outer",
                                ["[l"] = "@loop.outer",
                            },
                            goto_previous_end = {
                                ["[F"] = "@function.outer",
                                ["[C"] = "@class.outer",
                                ["[A"] = "@parameter.outer",
                                ["[L"] = "@loop.outer",
                            },
                        },
                        swap = {
                            enable = true,
                            swap_next = {
                                ["<leader>na"] = "@parameter.inner", -- swap with next argument
                                ["<leader>nf"] = "@function.outer",  -- swap with next function
                            },
                            swap_previous = {
                                ["<leader>pa"] = "@parameter.inner", -- swap with previous argument
                                ["<leader>pf"] = "@function.outer",  -- swap with previous function
                            },
                        },
                    },
                })
            end,
        },

        -- Code folding with safer defaults
        {
            "kevinhwang91/nvim-ufo",
            dependencies = {"kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter"},
            config = function()
                vim.opt.foldmethod = "expr"
                vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
                vim.opt.foldlevel = 99  -- Start with all folds open
                vim.opt.foldenable = true
                -- Don't fold automatically on buffer enter
                vim.opt.foldlevelstart = 99

                require("ufo").setup({
                    provider_selector = function(_, _, _)
                        return {"treesitter", "indent"}
                    end,
                    -- Prevent automatic folding behavior
                    open_fold_hl_timeout = 0,
                    close_fold_kinds = {},
                })

                -- Explicit fold keymaps (not conflicting with ESC)
                vim.keymap.set("n", "zM", "<cmd>lua require('ufo').closeAllFolds()<CR>", {desc = "Close all folds"})
                vim.keymap.set("n", "zR", "<cmd>lua require('ufo').openAllFolds()<CR>", {desc = "Open all folds"})
                vim.keymap.set("n", "zc", "zc", {desc = "Close fold under cursor"})
                vim.keymap.set("n", "zo", "zo", {desc = "Open fold under cursor"})
            end
        }





    },


    -- Check for updates, notify on updates needed
    checker = {enabled = false, notify = false}
})
