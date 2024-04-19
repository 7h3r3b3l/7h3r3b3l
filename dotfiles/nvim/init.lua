vim.g.mapleader = ' '  -- Set leader key to space
vim.g.maplocalleader = ' ' 

vim.opt.backspace = "2" vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.swapfile = false

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
    -- Cappucin for theme
{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    -- ToggleTerm for terminal
{'akinsho/toggleterm.nvim', version = "*", config = true},
    -- Auto Complete quotes
{'windwp/nvim-autopairs',event = "InsertEnter",config = true,},
    -- Floating Terminal
{'voldikss/vim-floaterm'},
    -- Python LSP (Language Server Protocol)
{ "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim"
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    require('mason').setup()
    local mason_lspconfig = require 'mason-lspconfig'
    mason_lspconfig.setup {
        ensure_installed = { "pyright", "rust_analyzer" }
    }
    require("lspconfig").pyright.setup {
        capabilities = capabilities,
    }
  end
},
    -- Autocompletion
{ "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip"
  },
  config = function()
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local cmp = require('cmp')
    local luasnip = require('luasnip')

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end
      },
      completion = {
        autocomplete = false
      },
      mapping = cmp.mapping.preset.insert ({
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<s-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<c-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select=true }),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }
    })
  end
},
    -- Black for nvim
{'averms/black-nvim'},
    -- Table mode
{'dhruvasagar/vim-table-mode'},
    --  Rust Tools
{'simrat39/rust-tools.nvim'},
    -- Nerd Tree
{'preservim/nerdtree'},
    -- Init Telescope
{'nvim-telescope/telescope.nvim'},
{'nvim-lua/plenary.nvim'},
    -- Nvim Start With Style
{
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
        local startify_theme = require'alpha.themes.startify'
        startify_theme.section.header.val = {
            "                       7h3r3b3l                      ",
            "                         ::::.                       ",
            "                      =%@@@@@@#-                     ",
            "                    =@@@@@@@@@@@*                    ",
            "                   =@@@@@@@@@@@@@*                   ",
            "                  .@@@@@@@@@@@@@@@.                  ",
            "                  +@%@@@@@@@@@@@%@=                  ",
            "                  =%#@@@@@@@@@@@##-                  ",
            "                  -#@+..=@@@- :##*:                  ",
            "       :**:       .*%    #@@   :+:                   ",
            "      .@@@#       +@@-.:+@#@=  *@%.                  ",
            "       =*#.       :#@@@@@* +@@@@@*      =%%= -#*     ",
            "   =%%####%%*=       .-@@*:*@@=.        %@@@%@@@+    ",
            "   =##@+-=++=:       #.=@@@@@* #        %@@@@@@@=    ",
            "      %+-#.          %--#####::%        :@@@@@@%     ",
            "      :%=@           @-::=--:.-%         .#@@@*      ",
            "       -*-           %@*-=::--#@           -#=       ",
            "        :            :%@@@@@@@@+                     ",
            "                       +@@@@@*:                      ",
            "                                                     ",
            "             ::                       :++:           ",
            "            *@@#+==--==+++***+++=--+#%@@@-           ",
            "            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@-           ",
            "           -@@@@@@@@%##**+++++++*#%@@@@@@@.          ",
            "           =@@@#*=:.                .:-+%#           ",
            "            ::                                       ",

        }
        require'alpha'.setup(startify_theme.config)
    end
}

}

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
vim.api.nvim_set_keymap('n', '<leader>t', ':FloatermNew<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>g', ':FloatermNew cargo run<CR>', { noremap = true, silent = true })



-- Open Lazygit
vim.api.nvim_set_keymap('n', '<leader>g', ':FloatermNew lazygit<CR>', { noremap = true, silent = true })

-- Open Nerd Tree
vim.api.nvim_set_keymap('n', '<leader>n', ':NERDTree<CR>', { noremap = true, silent = true })


-- Execute Python File
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "python" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<leader><leader>", ":FloatermNew python % ;echo '[+] process finished with no errors'; sleep 1000000 <CR><CR>", { noremap = true })
  end,
})

-- Execute Rust File
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "rust" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<leader><leader>", ":FloatermNew cargo run; echo '[+] process finished with no errors'; sleep 1000000<CR><CR>", { noremap = true })
  end,
})



-- Autocomplete rust
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

-- Run Telescope Find Files
vim.api.nvim_set_keymap('n', '<leader>f', ':Telescope find_files<CR>', { noremap = true, silent = true })


-- Go To Main
vim.api.nvim_set_keymap('n', '<leader>a', ':Alpha <CR>', { noremap = true, silent = true })
