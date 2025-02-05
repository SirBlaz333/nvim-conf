local lsp = require('lsp-zero')

lsp.preset('recommended')

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'tsserver', 'rust_analyzer', 'eslint', 'lua_ls', 'clangd', 'jdtls', 'html'},
  handlers = {
    lsp.default_setup,
  }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
  cmp.setup({
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
	  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
	  ["<C-Space>"] = cmp.mapping.complete(),
    })
  })

  cmp.setup({
    sources = {
      {name = 'nvim_lsp'},
    }
  })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
      local opts = {buffer = ev.buf, remap = false}

      vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
      vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
      vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
      vim.keymap.set("n", "<leader>vd", function() vim.lsp.buf.open_float() end, opts)
      vim.keymap.set("n", "[d", function() vim.lsp.buf.goto_next() end, opts)
      vim.keymap.set("n", "]d", function() vim.lsp.buf.goto_prev() end, opts)
      vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
      vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
      vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
      vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  end,
})

lsp.setup()
