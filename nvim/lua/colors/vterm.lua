-- "vterm": a terminal-native theme. It leaves the background transparent so the
-- terminal emulator's own background shows through, and maps syntax to the 16
-- ANSI palette colors (0-15) via cterm attributes. This only takes effect when
-- 'termguicolors' is off, so apply() in colorscheme-conf.lua disables it for
-- this theme and re-enables it for the truecolor themes.
local M = {}

-- ANSI palette indices. Their actual hues come from the terminal emulator, so
-- the theme automatically matches whatever colors the terminal is configured
-- with.
M.colors = {
    black     = 0,
    red       = 1,
    green     = 2,
    yellow    = 3,
    blue      = 4,
    magenta   = 5,
    cyan      = 6,
    white     = 7,
    gray      = 8,  -- bright black
    br_white  = 15,
}

M.groups = {
    -- Core UI. Backgrounds are left unset so they reset to NONE (transparent)
    -- after `highlight clear`, letting the terminal background show through.
    Normal      = { ctermfg = "NONE" },  -- inherit terminal foreground
    NormalFloat = { link = "Normal" },
    WinSeparator = { ctermfg = M.colors.gray },
    Pmenu       = { ctermfg = M.colors.white, ctermbg = M.colors.gray },
    PmenuSel    = { ctermfg = M.colors.black, ctermbg = M.colors.white },

    LineNr          = { ctermfg = M.colors.gray },
    CursorLine      = {},
    CursorLineNr    = { ctermfg = M.colors.br_white, bold = true, cterm = { bold = true } },

    Visual      = { reverse = true, cterm = { reverse = true } },
    Directory   = { ctermfg = M.colors.blue, bold = true, cterm = { bold = true } },
    MatchParen  = { ctermfg = M.colors.red, bold = true, cterm = { bold = true } },

    StatusLine      = { ctermfg = M.colors.white, ctermbg = M.colors.gray },
    StatusLineNC    = { ctermfg = M.colors.gray, ctermbg = M.colors.black },

    DiffAdd     = { ctermfg = M.colors.green },
    DiffDelete  = { ctermfg = M.colors.red },

    NeogitDiffAdd = { link = "DiffAdd" },
    NeogitDiffAddCursor = { link = "DiffAdd" },
    NeogitDiffAddHighlight = { link = "DiffAdd" },

    NeogitDiffDelete = { link = "DiffDelete" },
    NeogitDiffDeleteCursor = { link = "DiffDelete" },
    NeogitDiffDeleteHighlight = { link = "DiffDelete" },

    NeogitDiffContext = {},
    NeogitDiffContextHighlight = { link = "NeogitDiffContext" },

    -- Syntax groups
    Special     = { ctermfg = M.colors.red },
    Keyword     = { ctermfg = M.colors.blue, bold = true, cterm = { bold = true } },
    Identifier  = { ctermfg = "NONE" },
    Operator    = { ctermfg = M.colors.gray },
    Comment     = { ctermfg = M.colors.gray, italic = true, cterm = { italic = true } },
    String      = { ctermfg = M.colors.green },
    Function    = { ctermfg = M.colors.cyan },
    Type        = { ctermfg = M.colors.yellow },
    Constant    = { ctermfg = M.colors.magenta },
    Boolean     = { link = "Constant" },
    Number      = { link = "Constant" },
    Float       = { link = "Constant" },
    Macro       = { link = "Function" },
    PreProc     = { link = "Macro" },

    -- Tree-sitter groups
    ["@variable"]                   = { link = "Identifier" },
    ["@variable.builtin"]           = { link = "Keyword" },
    ["@variable.parameter"]         = { link = "Identifier" },
    ["@variable.parameter.builtin"] = { link = "Keyword" },
    ["@variable.member"]            = { link = "Identifier" },

    ["@constant"]         = { link = "Identifier" },
    ["@constant.builtin"] = { link = "Identifier" },
    ["@constant.macro"]   = { link = "PreProc" },

    ["@module"]         = { link = "Identifier" },
    ["@module.builtin"] = { link = "Keyword" },
    ["@label"]          = { link = "Identifier" },

    ["@string"]                 = { link = "String" },
    ["@string.documentation"]   = { link = "String" },
    ["@string.regexp"]          = { link = "String" },
    ["@string.escape"]          = { link = "Keyword" },
    ["@string.special"]         = { link = "String" },
    ["@string.special.symbol"]  = { link = "String" },
    ["@string.special.path"]    = { link = "String" },
    ["@string.special.url"]     = { link = "String" },

    ["@character"]          = { link = "String" },
    ["@character.special"]  = { link = "Keyword" },

    ["@boolean"]        = { link = "Boolean" },
    ["@number"]         = { link = "Number" },
    ["@number.float"]   = { link = "Float" },

    ["@type"]               = { link = "Type" },
    ["@type.builtin"]       = { link = "Type" },
    ["@type.definition"]    = { link = "Identifier" },

    ["@attribute"]          = { link = "Constant" },
    ["@attribute.builtin"]  = { link = "Constant" },
    ["@property"]           = { link = "Identifier" },

    ["@function"]           = { link = "Function" },
    ["@function.builtin"]   = { link = "Function" },
    ["@function.call"]      = { ctermfg = M.colors.cyan, bold = true, cterm = { bold = true } },
    ["@function.macro"]     = { link = "Macro" },

    ["@function.method"]        = { link = "Function" },
    ["@function.method.call"]   = { link = "@function.call" },

    ["@constructor"]    = { link = "Operator" },
    ["@operator"]       = { link = "Operator" },

    ["@keyword"]            = { link = "Keyword" },
    ["@keyword.coroutine"]  = { link = "Keyword" },
    ["@keyword.function"]   = { link = "Keyword" },
    ["@keyword.operator"]   = { link = "Keyword" },
    ["@keyword.import"]     = { link = "Keyword" },
    ["@keyword.type"]       = { link = "Keyword" },
    ["@keyword.modifier"]   = { link = "Keyword" },
    ["@keyword.repeat"]     = { link = "Keyword" },
    ["@keyword.return"]     = { link = "Keyword" },
    ["@keyword.debug"]      = { link = "Keyword" },
    ["@keyword.exception"]  = { link = "Keyword" },

    ["@keyword.conditional"]            = { link = "Keyword" },
    ["@keyword.conditional.ternary"]    = { link = "Keyword" },

    ["@keyword.directive"]          = { link = "Macro" },
    ["@keyword.directive.define"]   = { link = "Macro" },

    ["@punctuation.delimiter"] = { link = "Operator" },
    ["@punctuation.bracket"]   = { link = "Operator" },
    ["@punctuation.special"]   = { link = "Operator" },

    ["@comment"]               = { link = "Comment" },
    ["@comment.documentation"] = { link = "Comment" },

    ["@diff.plus"]  = { link = "DiffAdd" },
    ["@diff.minus"] = { link = "DiffDelete" },
}

M.updates = {
    SpellBad    = { undercurl = false, underline = true },
    SpellCap    = { undercurl = false, underline = true },
    SpellLocal  = { undercurl = false, underline = true },
    SpellRare   = { undercurl = false, underline = true },
}

function M.setup()
    vim.o.background = "dark"
    -- Fall back to the terminal's ANSI palette so the cterm colors below apply.
    vim.o.termguicolors = false
    vim.cmd[[highlight clear]]
    if vim.fn.exists("syntax_on") then vim.cmd[[syntax reset]] end
    vim.g.colors_name = "vterm"

    for group, opts in pairs(M.groups) do
        vim.api.nvim_set_hl(0, group, opts)
    end

    for group, opts in pairs(M.updates) do
        local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group })
        if ok then
            opts = vim.tbl_extend("force", hl, opts)
            vim.api.nvim_set_hl(0, group, opts)
        end
    end
end

return M
