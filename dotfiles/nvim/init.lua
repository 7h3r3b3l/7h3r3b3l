vim.g.mapleader = ' '  -- Set leader key to space
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
    -- PLUGINS HERE
{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
{'akinsho/toggleterm.nvim', version = "*", config = true},

}
local opts = {}


--  CONFIGURATION OF THE THEME
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
        frappe = {
            base = "#000000",
        },
        macchiato = {
            base = "#000000",
        },
    transparent_background = true,
    }
}
-- ELECTION OF THE THEME, CAN BE FRAPPE, MOCHA, LATE OR MACCHIATO
vim.cmd.colorscheme "catppuccin-frappe"

-- Configuration of ToggleTerm

require("toggleterm").setup{}

--  Init terminal with <SPACE>T 
vim.api.nvim_set_keymap('n', '<leader>t', ':ToggleTerm<CR>', { noremap = true, silent = true })




-- Execute Python File

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "python" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<leader><leader>", ":!python %<CR>", { noremap = true })
  end,
})
