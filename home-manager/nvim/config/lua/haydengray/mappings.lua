vim.keymap.set('n', '<leader>fe', ':Explore<CR><CR>', {})
vim.keymap.set('n', '<esc>', ':noh<CR>', {})

local telescope_present, builtin = pcall(require, 'telescope.builtin')
if telescope_present then
  vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
end

local harpoon_present = pcall(require, 'harpoon')
if harpoon_present then
  vim.keymap.set('n', '<leader>mf', require('harpoon.mark').add_file, {})
  vim.keymap.set('n', '<leader>rm', require('harpoon.mark').rm_file, {})
  vim.keymap.set('n', '<leader>hf', require('harpoon.ui').toggle_quick_menu, {})
  vim.keymap.set('n', '<leader>fh', ':Telescope harpoon marks<CR>', {})
end
