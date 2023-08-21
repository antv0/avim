vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move left" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move right" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move down" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move up" })
vim.keymap.set("n", "<Esc>", ":noh<CR>", { desc = "Clear highlights" })
vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", { desc = "New buffer" })
vim.keymap.set("n", "<leader>x", "<cmd> bdelete <CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<Tab>", "<cmd> bn <CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd> bp <CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "ZZ", "<cmd> q! <CR>", { desc = "Quit without saving" })
vim.keymap.set('n', 'H', require('treesj').toggle)
vim.keymap.set(
  'n',
  '<leader>ff',
  "<cmd> Telescope find_files follow=true <CR>"
)
vim.keymap.set(
  'n',
  '<leader>fF',
  "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>"
)
vim.keymap.set('n', '<leader>ft', MiniFiles.open, { desc = "Open file tree" })
-- vim.api.nvim_set_keymap('v', 'f', '<Plug>SnipRun', {silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>f', '<Plug>SnipRunOperator', {silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>ff', '<Plug>SnipRun', {silent = true})
vim.keymap.set('n', '<leader>rr', ":SnipRun<cr>", { desc = "Run line" })
vim.keymap.set('v', '<leader>r', ":SnipRun<cr>", { desc = "Run selection" })

vim.keymap.set('n', '<leader>N', "<cmd> Neogit <cr>", { desc = "Open Neogit" })
vim.keymap.set('n', '<a-f1>', "<cmd> Copilot <cr>", { desc = "Start Copilot" })

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[[', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']]', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>ra', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>fm', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- Descriptions for lspconfig mappings
local wk = require("which-key")
wk.register({
  ["<leader>e"] = { vim.diagnostic.open_float, "Show diagnostics" },
  ["[["] = { vim.diagnostic.goto_prev, "Previous diagnostic" },
  ["]]"] = { vim.diagnostic.goto_next, "Next diagnostic" },
  ["<leader>q"] = { vim.diagnostic.setloclist, "Set location list" },
  ["gD"] = { vim.lsp.buf.declaration, "Goto declaration" },
  ["gd"] = { vim.lsp.buf.definition, "Goto definition" },
  ["K"] = { vim.lsp.buf.hover, "Hover" },
  ["gi"] = { vim.lsp.buf.implementation, "Goto implementation" },
  ["<C-k>"] = { vim.lsp.buf.signature_help, "Signature help" },
  ["<leader>D"] = { vim.lsp.buf.type_definition, "Goto type definition" },
  ["<leader>ra"] = { vim.lsp.buf.rename, "Rename" },
  ["<leader>ca"] = { vim.lsp.buf.code_action, "Code action" },
  ["gr"] = { vim.lsp.buf.references, "Goto references" },
  ["<leader>fm"] = { function()
    vim.lsp.buf.format { async = true }
  end, "Format" },

})
