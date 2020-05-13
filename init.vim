set encoding=utf-8

" Use the space key as our leader. Put this near the top of your vimrc
	let mapleader = "\<Space>"



" ####################### Vim Plug #####################################
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'tpope/vim-surround'

" Initialize plugin system
call plug#end()



" ####################### Settings ################################
	set number                      " Display line numbers beside buffer
	set nocompatible                " Don't maintain compatibilty with Vi.
	set hidden                      " Allow buffer change w/o saving
	set lazyredraw                  " Don't update while executing macros
	set backspace=indent,eol,start  " Sane backspace behavior
	set history=1000                " Remember last 1000 commands
	set scrolloff=4                 " Keep at least 4 lines below cursor




" ##################### Helpers for VimRC ############################
" Split edit your vimrc. Type space, v, r in sequence to trigger
	nmap <leader>vr :sp $MYVIMRC<cr>

" Edit your vimrc in a new tab
	nmap <leader>vi :tabedit $MYVIMRC<cr>

" Source (reload) your vimrc. Type space, s, o in sequence to trigger
	nmap <leader>so :source $MYVIMRC<cr>



" ##################### Shortcuts ###################################
" help shortcuts
	" help hotkeys
	nmap <leader>hh :h :map-special-keys<cr> 

	" help set options
	nmap <leader>hs :browse set<cr>
	
	" help Autocmd
	nmap <leader>hac :h autocmd-events<cr>
	
	" Bind `q` to close the buffer for help files
	autocmd Filetype help nnoremap <buffer> q :q<CR>

" Vim Insert Mode escape
	imap jk <esc>
	imap kj <esc>

" Exits insert mode and saves buffer
	imap <C-s> <esc>:w<cr>
" Saves Buffer in Normal mode
	nnoremap <C-s> :w<cr>



" ##################### Window management ###########################
" Pre-populate a split command with the current directory
	nmap <leader>v :vnew <C-r>=escape(expand("%:p:h"), ' ') . '/'<cr>

" Copy the entire buffer into the system register
	nmap <leader>co ggVG*y

" Edit the db/schema.rb Rails file in a split
" nmap <leader>sc :split db/schema.rb<cr>

" Move up and down by visible lines if current line is wrapped
	nmap j gj
	nmap k gk

" Command aliases for typos
	command! Q q " Bind :Q to :q
	command! Qall qall
	command! QA qall
	command! E e

