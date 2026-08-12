return {
    'neovim/nvim-lspconfig',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'saghen/blink.cmp',
    },
    config = function()
        -- Merge blink.cmp's completion capabilities into every server config.
        vim.lsp.config('*', {
            capabilities = require('blink.cmp').get_lsp_capabilities(),
        })

        -- Neovim 0.11 auto-loads lsp/<name>.lua from the runtimepath; we only
        -- need to enable each server that has a config file in lsp/.
        local lsp_dir = vim.fn.stdpath('config') .. '/lsp'
        local servers = {}
        for _, file in ipairs(vim.fn.readdir(lsp_dir)) do
            local name = file:match('(.+)%.lua$')
            if name then
                table.insert(servers, name)
            end
        end
        vim.lsp.enable(servers)
    end,
}
