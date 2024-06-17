require "nvchad.options"

local opt = vim.o

-- Set the font for Neovide
opt.guifont = "FiraCode Nerd Font Mono:h14"

-- Set git bash as default terminal
if vim.fn.has('win32') == 1 then
  opt.shell = "C:\\Program Files\\Git\\bin\\bash.exe"
  opt.shellcmdflag = "-s"
end
