return {
	'nvim-telescope/telescope.nvim', tag = '0.1.6',
	-- or                              , branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },

	config = function()
		require('telescope').setup({})

		local builtin = require('telescope.builtin')

		vim.keymap.set('n', '<leader>ff', function() builtin.find_files{} end, {})
		vim.keymap.set('n', '<leader>fh', function() builtin.find_files{hidden = {true}} end, {})
		vim.keymap.set('n', '<leader>fg', "<cmd>Telescope live_grep <cr>", {desc = "search pattern in all the files under CWD"})
		vim.keymap.set('n', '<leader>fc', function()
			-- You can pass additional configuration to Telescope to change the theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
				winblend = 10,
				previewer = false,
			})
			end, { desc = '[/] Fuzzily search in current buffer' })

		-- Shortcut for searching your Neovim configuration files
		vim.keymap.set('n', '<leader>sn', function()
			builtin.find_files { cwd = vim.fn.stdpath 'config' }
			end, { desc = '[S]earch [N]eovim files' })


	end	
}
