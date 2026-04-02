require('gitsigns').setup({
    signs = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 500,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%y/%m/%d> · <summary>',
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true, desc = 'git: next hunk' })

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true, desc = 'git: previous hunk' })

        -- Hunk actions
        map('n', '<leader>hs', gs.stage_hunk,                                              { desc = 'git: stage hunk' })
        map('n', '<leader>hr', gs.reset_hunk,                                              { desc = 'git: reset hunk' })
        map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { desc = 'git: stage hunk (visual)' })
        map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { desc = 'git: reset hunk (visual)' })
        map('n', '<leader>hS', gs.stage_buffer,                                            { desc = 'git: stage buffer' })
        map('n', '<leader>hu', gs.undo_stage_hunk,                                         { desc = 'git: undo stage hunk' })
        map('n', '<leader>hR', gs.reset_buffer,                                            { desc = 'git: reset buffer' })
        map('n', '<leader>hp', gs.preview_hunk,                                            { desc = 'git: preview hunk' })
        map('n', '<leader>hb', gs.toggle_current_line_blame,                               { desc = 'git: toggle line blame' })
        map('n', '<leader>hl', gs.toggle_linehl,                                           { desc = 'git: toggle line highlight' })
        map('n', '<leader>hw', gs.toggle_word_diff,                                        { desc = 'git: toggle word diff' })
        map('n', '<leader>hd', gs.diffthis,                                                { desc = 'git: diff this' })
        map('n', '<leader>hD', function() gs.diffthis('~') end,                            { desc = 'git: diff against last commit' })
        map('n', '<leader>td', gs.toggle_deleted,                                          { desc = 'git: toggle deleted lines' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'git: select hunk' })
    end
})
