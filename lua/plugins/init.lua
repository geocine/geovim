return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  -- These are some examples, uncomment them if you want to see them work!
  -- {
  -- 	"williamboman/mason.nvim",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"lua-language-server", "stylua",
  -- 			"html-lsp", "css-lsp" , "prettier"
  -- 		},
  -- 	},
  -- },
  --
  -- fix right when Codeium is enabled and nvim-cmp https://github.com/Exafunction/codeium.vim/pull/387
  -- vim.g.codeium_disable_bindings = 1
  -- {
  --   'Exafunction/codeium.vim',
  --   event = 'BufEnter'
  -- },
  {
  "nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			-- default
        "vim",
        "lua",
        "vimdoc",

        -- web
        "html",
        "css",

        -- custom
        "go",
        "python"
  		},
  	},
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async"
    },
    init = function()
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true
      }
      local lspconfig = require "lspconfig"
      local servers = { "html", "cssls", "gopls", "pylsp", "lua_ls" }
      for _, ls in ipairs(servers) do
          lspconfig[ls].setup({
              capabilities = capabilities
              -- you can add other fields for setting up lsp server in this table
          })
      end
      require('ufo').setup()
    end,
    lazy = false
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = {
      current_line_blame = true,
    },
  },
  {
    "mg979/vim-visual-multi",
    init = function()
      vim.g.VM_leader = '<leader>'
      vim.g.VM_maps = {
        ['Find Under']           = '<C-d>',
        ['Find Subword Under']   = '<C-d>'
      }
      vim.g.VM_theme = 'neon'
    end,
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'onsails/lspkind-nvim'
    },
    event = 'InsertEnter',
    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')
      cmp.setup({
        -- Specify completion sources
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'path' },
        }),
        -- Mapping configuration for tab and other keys
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<Down>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<Up>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
        }),

        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol'
          }),
        },

        -- Don't auto select item
        preselect = cmp.PreselectMode.None,

        -- Configure window for documentation
        window = {
          documentation = cmp.config.window.bordered(),
        },
      })

    end,
  }
}
