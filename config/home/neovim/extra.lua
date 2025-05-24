-- Set indents
vim.cmd([[
    set shiftwidth=4 smarttab expandtab tabstop=8 softtabstop=0
    set clipboard+=unnamedplus
    autocmd BufWritePre * lua vim.lsp.buf.format()
]])

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        -- Enable inlay hints
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable()
        end
    end
})

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- Rust tools
--[[
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
]]--

-- LSP Diagnostics Options Setup 
local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ""
    })
end

sign({name = "DiagnosticSignError", text = ""})
sign({name = "DiagnosticSignWarn", text = ""})
sign({name = "DiagnosticSignHint", text = ""})
sign({name = "DiagnosticSignInfo", text = ""})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = {"menuone", "noselect", "noinsert"}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option("updatetime", 300) 

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error 
-- Show inlay_hints more frequently 
vim.cmd([[
    set signcolumn=yes
    autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- Treesitter Plugin Setup 
require("nvim-treesitter.configs").setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting=false,
    },
    ident = { enable = true }, 
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    }
}

-- Completion Plugin Setup
local cmp = require("cmp")
cmp.setup({
    -- Enable LSP snippets
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        -- Add tab support
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        })
    },
    -- Installed sources:
    sources = {
        { name = "path" },                              -- file paths
        { name = "nvim_lsp", keyword_length = 3 },      -- from language server
        { name = "nvim_lsp_signature_help"},            -- display function signatures with current parameter emphasized
        { name = "nvim_lua", keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
        { name = "buffer", keyword_length = 2 },        -- source current buffer
        { name = "vsnip", keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
        { name = "calc"},                               -- source for math calculation
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        fields = {"menu", "abbr", "kind"},
        format = function(entry, item)
            local menu_icon ={
                nvim_lsp = "λ",
                vsnip = "⋗",
                buffer = "Ω",
                path = "🖫",
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },
})

-- Coc
vim.cmd([[
    autocmd VimEnter *.rs silent! exe "CocDisable" 
    autocmd BufEnter *.rs silent! exe "CocDisable" 
    autocmd BufLeave *.rs silent! exe "CocEnable"
]])

-- https://github.com/neovim/neovim/issues/30985
for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end

vim.cmd("colorscheme solarized-high")
