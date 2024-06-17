require "nvchad.mappings"

local map = vim.keymap.set
local opts = { noremap=true, silent=true }

map("n", ";", ":", { desc = "CMD enter command mode" })

-- Search Commands
map('n', '<C-S-p>', ':Telescope commands<CR>', opts)

-- Search Files
map('n', '<C-S-f>', ':Telescope live_grep<CR>', opts)

-- Delete Line
map('n', '<C-S-k>', '"_dd', opts)

-- Copy Line Up/Down
map('n', '<S-A-Up>', ':t-1<CR>', opts)
map('n', '<S-A-Down>', ':t.<CR>', opts)

-- Move line up
map('n', '<A-Up>', ':m .-2<CR>==', opts)
map('i', '<A-Up>', '<Esc>:m .-2<CR>==gi', opts)
map('v', '<A-Up>', ":m '<-2<CR>gv=gv", opts)

-- Move line down
map('n', '<A-Down>', ':m .+1<CR>==', opts)
map('i', '<A-Down>', '<Esc>:m .+1<CR>==gi', opts)
map('v', '<A-Down>', ":m '>+1<CR>gv=gv", opts)

-- Misc
map('n', '<C-q>', ':qa!<CR>', opts)

-- Tree toggle
map('n', '<C-b>', '<Cmd>NvimTreeToggle<CR>', opts)

-- Map Ctrl+Tab to focus the main buffer window
map('n', '<C-Tab>', '<C-W>p', opts)
map('i', '<C-Tab>', '<Esc><C-W>p', opts)

-- Define the toggle function
local diagnostics_visible = false

function _G.toggle_diagnostics()
  diagnostics_visible = not diagnostics_visible
  if diagnostics_visible then
    vim.diagnostic.show()
    print("Diagnostics shown")
  else
    vim.diagnostic.hide()
    print("Diagnostics hidden")
  end
end

-- Map the function to Alt+l
map('n', '<A-l>', ':lua toggle_diagnostics()<CR>', opts)
