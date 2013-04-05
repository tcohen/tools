"this is a test 3
set nocompatible
source $VIMRUNTIME/vimrc_example.vim

if has("win32")
  source $VIMRUNTIME/mswin.vim
	behave mswin
	set diffexpr=MyDiff()
  function MyDiff()
    let opt = ''
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    silent execute '!C:\Vim\vim62\diff -a ' . opt . '"' . v:fname_in . '" "' . v:fname_new . '" > "' . v:fname_out . '"'
	endfunction
	"set grepprg=sr32\ /s\"$*\"\ /d\ /x\ /I
	" maximize and hide titlebar "call libcallnr("vimtweak.dll", "EnableMaximize", 1)
	"call libcallnr("vimtweak.dll", "EnableCaption", 1)
	" (also available,)
	"call libcallnr("vimtweak.dll", "EnableTopMost", 1)
	"call libcallnr("vimtweak.dll", "SetAlpha", 100)
	" set makeprg
	set makeprg=m.bat
	if has("gui_running")
    " Open the folder containing the currently open file. Double <CR> at end
    " is so you don't have to hit return after command. Double quotes are
    " not necessary in the 'explorer.exe %:p:h' section.
    :map <silent> <C-E> :if expand("%:p:h") != ""<CR>:!start explorer.exe %:p:h<CR>:endif<CR><CR>
    " If the current buffer has never been saved, it will have no name,
    " call the file browser to save it, otherwise just save it.
    :map <silent> <C-S> :if expand("%") == ""<CR>:browse confirm w<CR>:else<CR>:confirm w<CR>:endif<CR>
    " start maximized
    au GUIEnter * simalt ~x
	endif
endif

	colorscheme darkblue
	" map Shift-Space to ESC
	":map! <S-space> <esc>
	" map Space to insert one character
	:nmap <space> i_<esc>r
	" create EX command to unset readonly on current file
	"fun! UnsetReadonlyBit()
	"let fname = expand("%:p")
	":checktime
	"exec "au FileChangedShell " . fname . " :echo"
	":silent !attrib -r %
	":checktime
	"exec "au! FileChangedShell " . fname
	"endfun
	"command -nargs=0 Dummy call UnsetReadonlyBit()
	" set how many lines of context are maintained above and below the cursor
	set scrolloff=5
	" map Ctrl-{direction} to select and maximize split
	nmap <c-j> <c-w>j<c-w>_
	nmap <c-k> <c-w>k<c-w>_
	nmap <c-h> <c-w>h<c-w>_
	nmap <c-l> <c-w>l<c-w>_
	" number of lines in "minimized" split
	set wmw=1
" use home-row directionals in command mode (with Ctrl)
:cnoremap <C-H> <Left>
:cnoremap <C-L> <Right>
:cnoremap <C-K> <Up>
:cnoremap <C-J> <Down>
" Map key to toggle opt - see www.vim.org Tip #920
function MapToggle(key, opt)
let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
exec 'nnoremap '.a:key.' '.cmd
exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command -nargs=+ MapToggle  call MapToggle(<f-args>)
" Display-altering option toggles
MapToggle <F1> hlsearch
MapToggle <F2> wrap
MapToggle <F3> list
" Behavior-altering option toggles
MapToggle <F10> scrollbind
MapToggle <F11> ignorecase
MapToggle <F12> paste
set pastetoggle=<F12>
" center searches
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz
" Perforce integration
let p4EnableMenu=1
let p4EnablePopupMenu=1
let p4UseExpandedPopupMenu=1
let g:p4CodelineRoot = $P4_CODELINES_ROOT
let g:p4DefaultDiffOptions = '-dc'
" tab settings
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
"set listchars=tab:>-
"set list
set laststatus=2
" set visualbeep
set vb
" set autowrite
set autowrite
" set backup directory
set backupdir=~/tools/vim_user/backupdir
" agressive folding
"set foldmethod=syntax
"set foldopen=all
"set foldclose=all
" hebrew support
"source tools/vim_user/hebrew_support\_vimrc_hebrew_support
" see output of make
set shellpipe=\|\ tee
" disable the toolbar
set guioptions-=T
" ignore case in searches
set ignorecase
set cindent
" set viminfo
"	'	Maximum number of previously edited files for which the marks
"		are remembered.  This parameter must always be included when
"		'viminfo' is non-empty.
"	<	Maximum number of lines saved for each register.  If zero then
"		registers are not saved.  When not included, all lines are
"		saved.  '"' is the old name for this item.
"		Also see the 's' item below: limit specified in Kbyte.
"	h	Disable the effect of 'hlsearch' when loading the viminfo
"		file.  When not included, it depends on whether ":nohlsearch"
"		has been used since the last search command.
"	r	Removable media.  The argument is a string (up to the next
"		',').  This parameter can be given several times.  Each
"		specifies the start of a path for which no marks will be
"		stored.  This is to avoid removable media.  For MS-DOS you
"		could use "ra:,rb:", for Amiga "rdf0:,rdf1:,rdf2:".  You can
"		also use it for temp files, e.g., for Unix: "r/tmp".  Case is
"		ignored.  Maximum length of each 'r' argument is 50
"		characters.
"	%	When included, save and restore the buffer list.  If Vim is
"		started with a file name argument, the buffer list is not
"		restored.  If Vim is started without a file name argument, the
"		buffer list is restored from the viminfo file.	Buffers
"		without a file name and buffers for help files are not written
"		to the viminfo file.
"	!	When included, save and restore global variables that start
"		with an uppercase letter, and don't contain a lowercase
"		letter.  Thus "KEEPTHIS and "K_L_M" are stored, but "KeepThis"
"		and "_K_L_M" are not.set viminfo='20,<50,h,rA:,rB:,%,!
" map <Leader>/ to mruex list
let mruex_key='_<Leader>/'
" add file to mrulist whenever it is entered
" this avoids a few bugs related to using it, including
"   losing colors, getting a ":" prompt after every write, and
"   resetting split sizes.
let mruex_type='e'
" don't show the {, }, (, or ) marks with showmarks.vim
let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
" other options: ".'`^<>[]\""
" enable the HiMtchBrkt script by default (Highlights mathching bracket in
" normal mode)
" http://www.vim.org/scripts/script.php?script_id=1435
let g:HiMtchBrktOn=0
" configure ScreenShot
let ScreenShot = {'Title':1, 'Icon':0, 'Credits':0}
" map <Leader>z to make
"   (note: showmarks.vim uses \m{?} for its commands,
"   bufexplorer.vim uses \b{?} for its, etc.)
nnoremap <silent> <Leader>z :make<cr>
" map <Leader>e to edit another file in current directory
nnoremap <Leader>e :e <c-R>%<c-w><c-w><c-w>
nnoremap <Leader>sp :sp <c-R>%<c-w><c-w><c-w>
" map <Leader>t to open NERD Tree
nnoremap <Leader>t :NERDTree <c-R>%<c-w><c-w><c-w>
" map CTRL-P to replace word with \" buffer, without changing \" buffer
"TMC TODO "map <C-P> d"xwgPb
" remap g] to preview tag
map g] :ptjump <C-R><C-W><CR>
" comment and uncomment visual block
"vmap <c-u> :-1/^\/\//s///<CR>
"vmap <c-c> :-1/^/s//\/\//<CR>
" ctrl-left/right to navigate tabs
map <c-left> :tabprev<cr>
map <c-right> :tabnext<cr>

"expand grep to search for word under the cursor & open quickfix
" http://vim.wikia.com/wiki/Find_in_files_within_Vim
cabbrev grep lvim /\<lt><C-R><C-W>\>/gj **/*<C-R>=(expand("%:e")=="" ? "" : ".".expand("%:e"))<CR> <Bar> lw <C-Left><C-Left><C-Left>

"insert tabulation guide
nnoremap <Leader>g i    //protection scope Type         name                = defaultValue;             //comments

" the vim clipboard and the Windows clipboard are the same
set clipboard=unnamed
" where to load plugins
set runtimepath=$VIMRUNTIME,tools/vim_user/
" use wildmenu http://www.vim.org/tips/tip.php?tip_id=1045
set wildmenu
"set wildmode=list:longest,full
set wildmode=full
"only jump to errors in quickfix (skip warnings)
"this doesn't work yet
"set errorformat=%f(%l) : %t%*\D%n: %m,%*[^"]"%f"%*\D%l: %m,%f(%l) : %m,%*[^ ] %f %l: %m,%f,:%l:%c:%m,%f(%l):%m,%f:%l:%m,%f|%l| error %m
" load my menus
source ~/tools/vim_user/user_menus.vim
" load project-specific settings
source ~/tools/vim_user/project.vim
" load cscope cross-reference for the project, if any
cscope add cscope.out
" use AntiWord to view MS Word documents
autocmd BufReadPre *.doc set ro
autocmd BufReadPre *.doc set hlsearch!
autocmd BufReadPost *.doc %!antiword "%"
" enable omnicompletion
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" edit the message of the day
" au VimEnter * e ~/tools/vim_user/MOTD.txt
" automatically read a file when it has changed outside of vim
set autoread
