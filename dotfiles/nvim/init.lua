vim.g.maploader = ' '
vim.g.maplocalleader = ' ' 

vim.opt.backspace = "2"
vim.opt.showcmd = true
vim.opt.laststatus = 2


-- Set tab spaces to 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Enable line numbers
vim.opt.number = true

-- Set auto-scrolling
vim.opt.scrolloff = 999

-- Lazy Package Manager
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

local plugins= {
{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
local opts = {}
require("lazy").setup(plugins, opts)
require("catppuccin").setup {
        color_overrides = {
        all = {
            text = "#ffffff",
        },
        latte = {
            base = "#000000",
            mantle = "#242424",
            crust = "#ffffff",
        },
        mocha = {
            base = "#000000",
        },
        frappe = {},
        macchiato = {},
    }
}
--vim.cmd.colorscheme "catppuccin-mocha"
vim.cmd.colorscheme "catppuccin-mocha"
