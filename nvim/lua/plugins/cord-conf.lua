-- Discord Rich Presence
-- shows the file/language you're editing in your Discord status
-- https://github.com/vyfor/cord.nvim

return {
    'vyfor/cord.nvim',
    build = ':Cord update',
    lazy = true,
    event = 'VeryLazy',

    opts = {
        editor = {
            tooltip = 'Neovim',
        },
        display = {
            theme = 'default',
        },
        idle = {
            enabled = true,
            timeout = 300000, -- ms before status is considered idle
            show_status = true,
        },
        text = {
            editing = function(opts) return 'Editing ' .. opts.filename end,
            viewing = function(opts) return 'Viewing ' .. opts.filename end,
            workspace = function(opts) return 'In ' .. opts.workspace end,
        },
    },
}
