return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
        local wk = require('which-key')
        wk.setup({
            preset = 'modern',
        })

        -- Register leader-prefix group names (Doom Emacs-style).
        wk.add({
            { '<leader>f', group = 'file' },
            { '<leader>b', group = 'buffer' },
            { '<leader>w', group = 'window' },
            { '<leader>t', group = 'toggle' },
            { '<leader>q', group = 'quit' },
            { '<leader>x', group = 'text/exec' },
            { '<leader>g', group = 'git' },
            { '<leader>h', group = 'help' },
            { '<leader>;', desc = 'command palette' },
            { "<leader>'", desc = 'terminal' },
        })
    end,
}
