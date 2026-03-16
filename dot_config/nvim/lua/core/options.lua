vim.wo.number = true -- set line numbers 
-- vim.o.relativenumber = true -- set relative line numbers

vim.g.have_nerd_font = true

vim.schedule(function()
        vim.opt.clipboard = 'unnamedplus'
end)
vim.opt.breakindent = true
vim.o.wrap = false -- Display lines as one long line
vim.o.linebreak = true -- Display lines with breaks
vim.o.mouse = 'a' -- Enable mouse mode
vim.o.autoindent = true -- Copy indent level from current line when starting new line
vim.o.ignorecase = true -- Case-insensitive search unless \C or capital letter in search
vim.o.smartcase = true -- Smart case

vim.o.undofile = true -- Save undo history
vim.o.updatetime = 250 -- Decrease update time
vim.o.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.o.backup = false -- creates a backup file
vim.o.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.o.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience
vim.opt.termguicolors = true -- set termguicolors to enable highlight groups
vim.o.whichwrap = 'bs<>[]hl' -- which "horizontal" keys are allowed to travel to prev/next line

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }


-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.o.scrolloff = 4 -- minimal number of screen lines to keep above and below the cursor
vim.o.sidescrolloff = 8 -- minimal number of screen columns either side of cursor if wrap is `false`
vim.o.expandtab = true -- convert tabs to spaces

vim.o.cursorline = true -- highlight the current line
vim.o.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.o.backspace = 'indent,eol,start' -- allow backspace o
vim.o.pumheight = 10 -- pop up menu height
vim.o.conceallevel = 0 -- so that `` is visible in markdown files
vim.o.fileencoding = 'utf-8' -- the encoding written to a file
vim.o.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.runtimepath:remove '/usr/share/vim/vimfiles' -- separate vim plugins from neovim in case vim still in use




