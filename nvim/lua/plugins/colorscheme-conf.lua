return {
    'folke/tokyonight.nvim',
    priority = 1000, -- load before other plugins so highlights apply correctly
    config = function()
        require('tokyonight').setup({
            style = 'night', -- 'night' (darkest) | 'storm' | 'moon' | 'day' (light)
        })

        -- Themes to cycle between. 'grayscale' and 'vterm' are custom themes in
        -- colors/; 'tokyonight-night' ships with the plugin above. 'vterm' is
        -- terminal-native: it needs 'termguicolors' off so Neovim uses the
        -- terminal's ANSI palette, so apply() toggles that per theme.
        local themes = { 'grayscale', 'vterm', 'tokyonight-night' }
        local default = 'grayscale'

        local function apply(name)
            -- vterm relies on the terminal's 16-color palette (cterm colors);
            -- the truecolor themes need termguicolors back on.
            vim.o.termguicolors = (name ~= 'vterm')
            vim.cmd.colorscheme(name)
        end

        local function toggle_theme()
            local current = vim.g.colors_name
            local idx = 1
            for i, name in ipairs(themes) do
                if name == current then
                    idx = i
                    break
                end
            end
            local next_theme = themes[idx % #themes + 1]
            apply(next_theme)
            vim.notify('colorscheme: ' .. next_theme)
        end

        apply(default)

        -- :Theme grayscale | :Theme tokyonight-night  (Tab-completes)
        vim.api.nvim_create_user_command('Theme', function(o)
            apply(o.args)
        end, {
            nargs = 1,
            complete = function()
                return themes
            end,
        })

        -- SPC t t = toggle between the two themes (shows up in which-key)
        vim.keymap.set('n', '<leader>tt', toggle_theme, { silent = true, desc = 'Toggle theme' })
    end,
}
