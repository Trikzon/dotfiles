-- smart indent
vim.opt.cindent = true
-- don't expand tabs to spaces
vim.opt.expandtab = false
-- render tabs as four spaces long
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- render tabs and trailing spaces as characters
vim.opt.list=true
vim.opt.listchars="tab:» ,trail:·"

vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"

-- move up and down through wrapped lines
vim.opt.smoothscroll = true

vim.opt.swapfile = false
vim.opt.undofile = true

-- highlight current line
vim.opt.cursorline = true
-- show current line number and relative lines numbers around it
vim.opt.number = true
vim.opt.relativenumber = true

