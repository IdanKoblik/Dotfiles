-- a simple sidebar file explorer
-- inside the tree: a = create file/dir (end name with / for a dir),
-- d = delete, r = rename, x = cut, c = copy, p = paste, <CR> = open

return {
    'nvim-tree/nvim-tree.lua',
    lazy = true,

    dependencies = { 'nvim-tree/nvim-web-devicons' },

    keys = {
        { '<leader>n', function() require('nvim-tree.api').tree.toggle() end, desc = "Toggle File Explorer" },
    },

    config = function()
        -- disable netrw so nvim-tree is the only file explorer
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require('nvim-tree').setup({
            view = {
                width = 35,
            },
            renderer = {
                group_empty = true,
            },
            actions = {
                open_file = {
                    quit_on_open = false,
                },
            },
        })
    end,
}
