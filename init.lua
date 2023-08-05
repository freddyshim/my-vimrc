--------------------------------------------------------------------------------
-- GENERAL
--------------------------------------------------------------------------------
vim.o.swapfile = false
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "

--------------------------------------------------------------------------------
-- PLUGINS
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- tmux compatability
  "christoomey/vim-tmux-navigator",
  -- syntax parser
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  -- themes
  "arcticicestudio/nord-vim",
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000
  },
  -- fuzzy file finder
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  -- navigation tree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup {}
    end
  },
  -- status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
  -- buffer line
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
  -- macros
  "tpope/vim-surround",
  "tpope/vim-repeat",
  -- autopair
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },
  -- language server protocol
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      {                            -- Optional
        "williamboman/mason.nvim",
        build = function()
          pcall(vim.cmd, "MasonUpdate")
        end,
      },
      { "williamboman/mason-lspconfig.nvim" }, -- Optional

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },     -- Required
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "L3MON4D3/LuaSnip" },     -- Required
    }
  },
  -- formatter
  {
    "MunifTanjim/prettier.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "jose-elias-alvarez/null-ls.nvim" }
    }
  }
})

--------------------------------------------------------------------------------
-- COLORS
--------------------------------------------------------------------------------
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.background = "dark"
vim.cmd.colorscheme("catppuccin-frappe")

--------------------------------------------------------------------------------
-- TEXT
--------------------------------------------------------------------------------
vim.opt.clipboard:append { "unnamed", "unnamedplus" }

--------------------------------------------------------------------------------
-- INDENTATION
--------------------------------------------------------------------------------
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.cindent = true

vim.api.nvim_create_autocmd("FileType", {
  desc = "4 spaces for Python and GDScript",
  pattern = { "python", "gdscript" },
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
  end
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "tabs for makefiles",
  pattern = { "make" },
  callback = function()
    vim.opt.expandtab = false
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
  end
})

--------------------------------------------------------------------------------
-- UI ELEMENTS
--------------------------------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showcmd = true
vim.opt.cursorline = true
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.title = true
vim.opt.colorcolumn = "80"

--------------------------------------------------------------------------------
-- SEARCH
--------------------------------------------------------------------------------
vim.opt.ignorecase = true
vim.opt.smartcase = true

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-F>", builtin.find_files, {})
vim.keymap.set("n", "<C-G>", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

--------------------------------------------------------------------------------
-- FOLDING
--------------------------------------------------------------------------------
vim.opt.foldenable = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 2
vim.opt.foldnestmax = 2

--------------------------------------------------------------------------------
-- NVIM-TREE
--------------------------------------------------------------------------------
require("nvim-tree").setup()
vim.keymap.set("n", "<C-N>", ":NvimTreeToggle<CR>")

--------------------------------------------------------------------------------
-- TREESITTER
--------------------------------------------------------------------------------
require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "cpp",
    "css",
    "dockerfile",
    "glsl",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "python",
    "rust",
    "scss",
    "svelte",
    "terraform",
    "typescript",
    "vim",
    "yaml",
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

--------------------------------------------------------------------------------
-- CATPPUCCIN
--------------------------------------------------------------------------------
require("catppuccin").setup({
  flavour = "frappe",
  integrations = {
    nvimtree = true
  }
})

--------------------------------------------------------------------------------
-- LUALINE
--------------------------------------------------------------------------------
require("lualine").setup({
  options = {
    theme = "catppuccin"
  }
})

--------------------------------------------------------------------------------
-- BUFFERLINE
--------------------------------------------------------------------------------
require("bufferline").setup {
  options = {
    diagnostics = "nvim_lsp"
  },
}
vim.keymap.set("n", "<leader>1", "<cmd>lua require('bufferline').go_to(1, false)<cr>", { buffer = false })
vim.keymap.set("n", "<leader>2", "<cmd>lua require('bufferline').go_to(2, false)<cr>", { buffer = false })
vim.keymap.set("n", "<leader>3", "<cmd>lua require('bufferline').go_to(3, false)<cr>", { buffer = false })
vim.keymap.set("n", "<leader>4", "<cmd>lua require('bufferline').go_to(4, false)<cr>", { buffer = false })
vim.keymap.set("n", "<leader>5", "<cmd>lua require('bufferline').go_to(5, false)<cr>", { buffer = false })
vim.keymap.set("n", "<leader>6", "<cmd>lua require('bufferline').go_to(6, false)<cr>", { buffer = false })
vim.keymap.set("n", "<leader>7", "<cmd>lua require('bufferline').go_to(7, false)<cr>", { buffer = false })
vim.keymap.set("n", "<leader>8", "<cmd>lua require('bufferline').go_to(8, false)<cr>", { buffer = false })
vim.keymap.set("n", "<leader>9", "<cmd>lua require('bufferline').go_to(9, false)<cr>", { buffer = false })
vim.keymap.set("n", "<leader>0", "<cmd>lua require('bufferline').go_to(0, false)<cr>", { buffer = false })


--------------------------------------------------------------------------------
-- LSP
--------------------------------------------------------------------------------
local lsp = require("lsp-zero").preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({
    buffer = bufnr,
    omit = { "<F2>", "<F3>", "<F4>" },
  })

  vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", { buffer = true })
  vim.keymap.set("n", "<leader>fm", "<cmd>lua vim.lsp.buf.format()<cr>", { buffer = true })
  vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", { buffer = true })
end)

require("mason-lspconfig").setup {
  ensure_installed = {
    "bashls",
    "clangd",
    "cmake",
    "cssls",
    "dockerls",
    "docker_compose_language_service",
    "eslint",
    "html",
    "jsonls",
    "lua_ls",
    "marksman",
    "pyright",
    "rust_analyzer",
    "svelte",
    "tailwindcss",
    "terraformls",
    "tsserver",
    "vimls",
    "yamlls"
  },
}

lsp.setup()

require("lspconfig").lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
})

local cmp = require("cmp")

cmp.setup({
  mapping = {
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  }
})

--------------------------------------------------------------------------------
-- LSP
--------------------------------------------------------------------------------
local null_ls = require("null-ls")

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      -- format on save
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
      vim.api.nvim_create_autocmd(event, {
        buffer = bufnr,
        group = group,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = async })
        end,
        desc = "[lsp] format on save",
      })
    end
  end,
})

local prettier = require("prettier")

prettier.setup({
  bin = 'prettierd',
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
})
