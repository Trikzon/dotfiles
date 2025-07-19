-- set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- don't expand tabs to spaces
vim.opt.expandtab = false
-- display tab characters as four spaces long
vim.opt.tabstop = 4
-- only indent by one tab character when pressing tab
vim.opt.softtabstop = 4
-- shift indents by only one tab character
vim.opt.shiftwidth = 4

-- indent automatically
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.cindent = true

-- render whitespace as characters
vim.opt.list = true
vim.opt.listchars = { leadmultispace = "▏···", nbsp = "␣", tab = "▏ ", trail = "·" }

-- show current line number and relative lines numbers around it
vim.opt.number = true
vim.opt.relativenumber = true
-- always show the sign column
vim.opt.signcolumn = "yes"

-- highlight current line
vim.opt.cursorline = true

-- don't use swap files
vim.opt.swapfile = false
-- save undo history between sessions
vim.opt.undofile = true

-- share system clipboard
vim.opt.clipboard = "unnamedplus"

-- enable mouse mode for all modes
vim.opt.mouse = "a"

-- don't show the mode since it's in the status line already
vim.opt.showmode = false

-- keep indents consistent in wrapped lines
vim.opt.breakindent = true
-- move up and down through wrapped lines
vim.opt.smoothscroll = true

-- use case-insensitive searching
vim.opt.ignorecase = true
-- unless one or more capital letters are searched for
vim.opt.smartcase = true

-- always open new splits to the right or the bottom
vim.opt.splitright = true
vim.opt.splitbelow = true

-- always keep at least ten lines above and below the cursor
vim.opt.scrolloff = 10

-- increase update time
vim.opt.updatetime = 500

