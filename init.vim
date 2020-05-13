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
    Plug 'tpope/vim-commentary' 
    "autocmd FileType apache setlocal commentstring=#\ %s
    
    Plug 'scrooloose/nerdtree'    " File Browser - Nerd Tree
    Plug 'davidhalter/jedi-vim'   " Python Plugin
    Plug 'fatih/vim-go'           " Go Plugin 
    
    " color schemes
    Plug 'rafi/awesome-vim-colorschemes'
  call plug#end()



" ####################### Settings ################################
	set number                      " Display line numbers beside buffer
	set nocompatible                " Don't maintain compatibilty with Vi.
	set hidden                      " Allow buffer change w/o saving
	set lazyredraw                  " Don't update while executing macros
	set backspace=indent,eol,start  " Sane backspace behavior
	set history=1000                " Remember last 1000 commands
	set scrolloff=4                 " Keep at least 4 lines below cursor
	set nobackup
        set nowritebackup
        set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
	
	" Softtabs, 2 spaces
	set tabstop=2
	set shiftwidth=2
	set shiftround
	set expandtab


  " Open new split panes to right and bottom, which feels more natural
  set splitbelow
  set splitright

  " Theme
  colorscheme atom
  " hi Comment guifg=#5C6370 ctermfg=59

" ##################### Helpers for VimRC ############################
"Split edit your vimrc. Type space, v, r in sequence to trigger
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

" Get off my lawn
  nnoremap <Left> :echoe "Use h"<CR>
  nnoremap <Right> :echoe "Use l"<CR>
  nnoremap <Up> :echoe "Use k"<CR>
  nnoremap <Down> :echoe "Use j"<CR>


" ##################### Window management ###########################
" Pre-populate a split command with the current directory
	nmap <leader>v :vnew <C-r>=escape(expand("%:p:h"), ' ') . '/'<cr>

" Copy the entire buffer into the system register
	nmap <leader>co ggVG*y

" Quicker window movement
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-h> <C-w>h
  nnoremap <C-l> <C-w>l

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

" Merge a tab into a split in the previous window
  function! MergeTabs()
    if tabpagenr() == 1
      return
    endif
    let bufferName = bufname("%")
    if tabpagenr("$") == tabpagenr()
      close!
    else
      close!
      tabprev
    endif
    split
    execute "buffer " . bufferName
  endfunction

  nmap <C-W>u :call MergeTabs()<CR>

" Git Shortcuts
  " Type message and press Enter (FIsh Shell alias)
	nnoremap <leader>gp :!gitpush 


" ###################### Silver Searcher #############################
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in fzf for listing files. Lightning fast and respects .gitignore
  let $FZF_DEFAULT_COMMAND = 'ag --literal --files-with-matches --nocolor --hidden -g ""'

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

" ###################### Helpers ######################################
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE (thanks Gary Bernhardt)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
      exec ':saveas ' . new_name
      exec ':silent !rm ' . old_name
      redraw!
    endif
  endfunction
  map <Leader>n :call RenameFile()<cr>

