-- ==============================
-- 💤 Bootstrap do lazy.nvim
-- ==============================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Define leader key como espaço
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ==============================
-- ⚙️ Configuração dos plugins
-- ==============================
require("lazy").setup({
  -- Dependências básicas
  { "nvim-lua/plenary.nvim" },

  -- Tema bonito
  { 
    "folke/tokyonight.nvim", 
    lazy = false,
    priority = 1000,
    transparent = true, 
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end
  },

  -- Fuzzy finder (Telescope)
  { 
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

  -- Ícones (DEVE vir antes do nvim-tree)
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function()
      require("nvim-web-devicons").setup({
        default = true,
        strict = true,
        override = {
          js = { icon = "", color = "#f7df1e", name = "Js" },
          py = { icon = "", color = "#3776ab", name = "Py" },
          json = { icon = "", color = "#fbc02d", name = "Json" },
          md = { icon = "", color = "#ffffff", name = "Md" },
        }
      })
    end,
  },

  -- File explorer (NvimTree)
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = { width = 35, relativenumber = true },
        renderer = {
          group_empty = true,
          indent_markers = { enable = true },
          icons = {
            show = { file = true, folder = true, folder_arrow = true, git = true },
            glyphs = {
              default = "",
              symlink = "",
              bookmark = "",
              modified = "●",
              folder = {
                arrow_closed = "",
                arrow_open = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
        filters = { dotfiles = false, custom = {} },
        actions = { open_file = { resize_window = true } }
