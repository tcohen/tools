" HiMtchBrkt : a rudimentary attempt to highlight matching brackets
"  Author:  Charles E. Campbell, Jr.  <drNchipO@ScampbellPfamilyA.Mbiz>-NOSPAM
"  Date:    Dec 29, 2005
"  Version: 17
"
" A Vim v6.0 plugin with menus for gvim
"
" Usage: {{{1
"   \[i : initialize highlighting of matching bracket
"   \[s : stop       highlighting of matching bracket
"
"   Actually, <Leader> is used, so you may set mapleader to change
"   the leading backslash to whatever you want in your <.vimrc>
"   See :help mapleader.
"
" GetLatestVimScripts: 1435 1 :AutoInstall: HiMtchBrkt.vim
" GetLatestVimScripts: 1066 1 cecutil.vim
" ---------------------------------------------------------------------
" Load Once: {{{1
if &cp || exists("g:loaded_HiMtchBrkt")
 finish
endif
let g:loaded_HiMtchBrkt = "v17"
let s:keepcpo           = &cpo
set cpo&vim

" ---------------------------------------------------------------------
" Public Interface: {{{1
if !hasmapto('<Plug>HMBStart')
 map <unique> <Leader>[i	<Plug>HMBStart
endif
if !hasmapto('<Plug>HMBStop')
 map <unique> <Leader>[s	<Plug>HMBStop
endif
com! HMBstart	:set lz|call <SID>HMBStart()|set nolz
com! HMBstop 	:set lz|call <SID>HMBStop()|set nolz

" ---------------------------------------------------------------------
" Global Maps: {{{1
nmap <silent> <unique> <script> <Plug>HMBStart :set lz<CR>:call <SID>HMBStart()<CR>:set nolz<CR>
nmap <silent> <unique> <script> <Plug>HMBStop  :set lz<CR>:call <SID>HMBStop()<CR>:set nolz<CR>

" DrChip menu support:
if has("gui_running") && has("menu")
 if !exists("g:DrChipTopLvlMenu")
  let g:DrChipTopLvlMenu= "DrChip."
 endif
 exe 'menu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Start<tab><Leader>[i	<Leader>[i'
endif

" =====================================================================
" HMBStart: {{{1
fun! <SID>HMBStart()
"  call Dfunc("HMBStart()")

  " set whichwrap
  let s:wwkeep= &ww
  set ww=b,s,<,>,[,]

  if exists("g:dohimtchbrkt") && g:dohimtchbrkt == 1
   " already in HiMtchBrkt mode
   if &cmdheight >= 2
    echo "[HiMtchBrkt]"
   endif
"   call Dret("HMBStart : already in HiMtchBrkt mode")
   return
  endif
  let g:dohimtchbrkt= 1
 
  " Save Maps (if any)
  call SaveUserMaps("n","",":F(","HiMtchBrkt")
  call SaveUserMaps("n","",":F)","HiMtchBrkt")
  call SaveUserMaps("n","",":F[","HiMtchBrkt")
  call SaveUserMaps("n","",":F]","HiMtchBrkt")
  call SaveUserMaps("n","",":F{","HiMtchBrkt")
  call SaveUserMaps("n","",":F}","HiMtchBrkt")
  call SaveUserMaps("n","",":f(","HiMtchBrkt")
  call SaveUserMaps("n","",":f)","HiMtchBrkt")
  call SaveUserMaps("n","",":f[","HiMtchBrkt")
  call SaveUserMaps("n","",":f]","HiMtchBrkt")
  call SaveUserMaps("n","",":f{","HiMtchBrkt")
  call SaveUserMaps("n","",":f}","HiMtchBrkt")
  call SaveUserMaps("n","","<c-b>","HiMtchBrkt")
  call SaveUserMaps("n","","<c-d>","HiMtchBrkt")
  call SaveUserMaps("n","","<c-f>","HiMtchBrkt")
  call SaveUserMaps("n","","<c-u>","HiMtchBrkt")
  call SaveUserMaps("n","","<down>","HiMtchBrkt")
  call SaveUserMaps("n","","<PageDown>","HiMtchBrkt")
  call SaveUserMaps("n","","<end>","HiMtchBrkt")
  call SaveUserMaps("n","","<home>","HiMtchBrkt")
  call SaveUserMaps("n","","<left>","HiMtchBrkt")
  call SaveUserMaps("n","","<right>","HiMtchBrkt")
  call SaveUserMaps("n","","<space>","HiMtchBrkt")
  call SaveUserMaps("n","","<up>","HiMtchBrkt")
  call SaveUserMaps("n","","<PageUp>","HiMtchBrkt")
  call SaveUserMaps("n","","webWEBjklh$0%;,nN","HiMtchBrkt")
  call SaveUserMaps("o","","<down>","HiMtchBrkt")
  call SaveUserMaps("o","","<end>","HiMtchBrkt")
  call SaveUserMaps("o","","<home>","HiMtchBrkt")
  call SaveUserMaps("o","","<left>","HiMtchBrkt")
  call SaveUserMaps("o","","<right>","HiMtchBrkt")
  call SaveUserMaps("o","","<up>","HiMtchBrkt")
  if has("gui_running") && has("menu")
   call SaveUserMaps("n","","<leftmouse>","HiMtchBrkt")
   call SaveUserMaps("o","","<leftmouse>","HiMtchBrkt")
  endif
  if v:version > 602 || v:version == 602 && has("patch405")
   call SaveUserMaps("n","","0","HiMtchBrkt")
  endif
 
  " indicate in HiMtchBrkt mode
  if &cmdheight >= 2
   echo "[HiMtchBrkt]"
  endif
 
  " Install HiMtchBrkt maps
  if has("gui_running") && has("menu")
   inoremap <silent> <down>      <down><c-o>:silent call <SID>HiMatchBracket()<CR>
   inoremap <silent> <up>        <up><c-o>:silent call <SID>HiMatchBracket()<CR>
   inoremap <silent> <right>     <right><c-o>:silent call <SID>HiMatchBracket()<CR>
   inoremap <silent> <left>      <left><c-o>:silent call <SID>HiMatchBracket()<CR>
   inoremap <silent> <home>      <home><c-o>:silent call <SID>HiMatchBracket()<CR>
   inoremap <silent> <end>       <end><c-o>:silent call <SID>HiMatchBracket()<CR>
   inoremap <silent> <PageUp>    <PageUp><c-o>:silent call <SID>HiMatchBracket()<CR>
   inoremap <silent> <PageDown>  <PageDown><c-o>:silent call <SID>HiMatchBracket()<CR>
   nnoremap <silent> <down>      <down><c-o>:silent call <SID>HiMatchBracket()<CR>
   nnoremap <silent> <up>        <up><c-o>:silent call <SID>HiMatchBracket()<CR>
   nnoremap <silent> <right>     <right><c-o>:silent call <SID>HiMatchBracket()<CR>
   nnoremap <silent> <left>      <left><c-o>:silent call <SID>HiMatchBracket()<CR>
   nnoremap <silent> <home>      <home><c-o>:silent call <SID>HiMatchBracket()<CR>
   nnoremap <silent> <end>       <end><c-o>:silent call <SID>HiMatchBracket()<CR>
   nnoremap <silent> <space>     <space><c-o>:silent call <SID>HiMatchBracket()<CR>
   nnoremap <silent> <PageUp>    <PageUp><c-o>:silent call <SID>HiMatchBracket()<CR>
   nnoremap <silent> <PageDown>  <PageDown><c-o>:silent call <SID>HiMatchBracket()<CR>
  else
   inoremap <silent> <down>      <c-o>j<c-o>:silent call <SID>HiMatchBracket()<CR>
   inoremap <silent> <up>        <c-o>k<c-o>:silent call <SID>HiMatchBracket()<CR>
   inoremap <silent> <right>     <c-o>l<c-o>:silent call <SID>HiMatchBracket()<CR>
   inoremap <silent> <left>      <c-o>h<c-o>:silent call <SID>HiMatchBracket()<CR>
   inoremap <silent> <home>      <c-o>0<c-o>:silent call <SID>HiMatchBracket()<CR>
   inoremap <silent> <end>       <c-o>$<c-o>:silent call <SID>HiMatchBracket()<CR>
   inoremap <silent> <PageUp>    <c-o><c-b><c-o>:silent call <SID>HiMatchBracket()<CR>
   inoremap <silent> <PageDown>  <c-o><c-f><c-o>:silent call <SID>HiMatchBracket()<CR>
   nnoremap <silent> <down>      j:silent call <SID>HiMatchBracket()<CR>
   nnoremap <silent> <up>        k:silent call <SID>HiMatchBracket()<CR>
   nnoremap <silent> <right>     l:silent call <SID>HiMatchBracket()<CR>
   nnoremap <silent> <left>      h:silent call <SID>HiMatchBracket()<CR>
   nnoremap <silent> <home>      0:silent call <SID>HiMatchBracket()<CR>
   nnoremap <silent> <end>       $:silent call <SID>HiMatchBracket()<CR>
   nnoremap <silent> <space>     l:silent call <SID>HiMatchBracket()<CR>
   nnoremap <silent> <PageUp>    <c-b>:silent call <SID>HiMatchBracket()<CR>
   nnoremap <silent> <PageDown>  <c-f>:silent call <SID>HiMatchBracket()<CR>
  endif
  if has("gui_running") && has("menu")
   nnoremap <silent> <leftmouse> <leftmouse>:silent call <SID>HiMatchBracket()<CR>
   inoremap <silent> <leftmouse> <leftmouse><c-o>:silent call <SID>HiMatchBracket()<CR>
  endif
  nnoremap <silent>   0         0:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>   b         b:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>   B         B:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>   e         e:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>   E         E:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>   h         h:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>   j         j:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>   k         k:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>   l         l:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>   n         n:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>   N         N:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>   $         $:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>   %         %:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>   w         w:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>   W         W:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent> <c-f>   <c-f>:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent> <c-b>   <c-b>:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent> <c-d>   <c-d>:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent> <c-u>   <c-u>:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>  f(        f(:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>  f)        f):silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>  f{        f{:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>  f}        f}:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>  f[        f[:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>  f]        f]:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>  F(        F(:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>  F)        F):silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>  F{        F{:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>  F}        F}:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>  F[        F[:silent call <SID>HiMatchBracket()<CR>
  nnoremap <silent>  F]        F]:silent call <SID>HiMatchBracket()<CR>
  if exists("mapleader")
   if mapleader != ';'
    nnoremap <silent>  ;        ;:silent call <SID>HiMatchBracket()<CR>
   endif
   if mapleader != ','
    nnoremap <silent>  ,        ,:silent call <SID>HiMatchBracket()<CR>
   endif
  else
    nnoremap <silent>  ;        ;:silent call <SID>HiMatchBracket()<CR>
    nnoremap <silent>  ,        ,:silent call <SID>HiMatchBracket()<CR>
  endif
  if v:version > 602 || v:version == 602 && has("patch405")
   nnoremap <silent>  0         0:silent call <SID>HiMatchBracket()<CR>
  endif
 
  " use CursorHold event to do a belated highlighing of matching bracket
  " to handle motions not directly handled above
  if !exists("g:himtchbrkt_nocursorhold")
   " keep and set options
   let g:himtchbrkt_utkeep= &ut
   set ut=200
   augroup HMBEvent
    au!
    au CursorHold * silent call s:HiMatchBracket()
   augroup END
  endif
 
  " Insert stop  HiMtchBrkt into menu
  " Delete start HiMtchBrkt from menu
  if has("gui_running") && has("menu")
   exe 'unmenu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Start'
   exe 'menu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Stop<tab><Leader>[s	<Leader>[s'
  endif
 
"  call Dret("HMBStart")
endfun

" ---------------------------------------------------------------------
" HMBStop: turn  HiMtchBrkt mode off: restore motion key maps to prior {{{1
" settings (if any), restore visual beeps, restore CursorHold update timer.
fun! <SID>HMBStop()
"  call Dfunc("HMBStop()")
  if !exists("g:dohimtchbrkt")
   if &cmdheight >= 2
    echo "[HiMtchBrkt off]"
   endif
"   call Dret("HMBStop")
   return
  endif
  unlet g:dohimtchbrkt
  match none
 
  " remove cursorhold event for highlighting matching bracket
  if !exists("g:himtchbrkt_nocursorhold")
   augroup HMBEvent
    au!
   augroup END
  endif
 
  if &cmdheight >= 2
   echo "[HiMtchBrkt off]"
  endif
 
  " restore user map(s), if any
  call RestoreUserMaps("HiMtchBrkt")
  let &ww= s:wwkeep
 
  " Insert start HiMtchBrkt into menu
  " Delete stop  HiMtchBrkt from menu
  if has("gui_running") && has("menu")
   exe 'unmenu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Stop'
   exe 'menu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Start<tab><Leader>[s	<Leader>[i'
  endif
"  call Dret("HMBStop")
endfun

" ---------------------------------------------------------------------
" HiMatchBracket: this routine actually performs the highlighting of {{{1
" the matching bracket.
fun! <SID>HiMatchBracket()
"  call Dfunc("HiMatchBracket()")

  " save
  let vbkeep   = &vb
  let t_vbkeep = &t_vb
  " turn beep/visual flash off
  set vb t_vb=

  let regq= @"
  let mps = substitute(&mps,'\(.\).','\1','g')
 
  norm! vy
"  call Decho("HiMatchBracket: stridx(mps<".mps.">,@0<".@0.">)=".stridx(mps,@0))
  if stridx(mps,@0) != -1
   let curline  = line('.')
   let curcol   = virtcol('.')
   norm! H
   let hline    = line('.')
   if hline != curline
    norm! ``
   endif
   norm! %
   let mtchline = line('.')
   let mtchcol  = virtcol('.')
   norm! %
   if hline == curline
    exe 'norm! '.curline.'G'.curcol."\<bar>"
   else
    exe 'norm! '.hline.'Gzt'.curline.'G'.curcol."\<bar>"
   endif
   exe 'match Search /\%'.mtchline.'l\%'.mtchcol.'v/'
"   call Decho("cur[".curline.",".curcol."] hline=".hline." mtch[".mtchline.",".mtchcol."]")
  else
   match none
  endif
 
  " restore
  let @"    = regq
  let &vb   = vbkeep
  let &t_vb = t_vbkeep

"  call Dret("HiMatchBracket")
endfun

" ---------------------------------------------------------------------

if exists("g:HiMtchBrktOn") && g:HiMtchBrktOn != 0
 silent HMBstart
endif

let &cpo= s:keepcpo
unlet s:keepcpo
" ---------------------------------------------------------------------
"  vim: ts=4 fdm=marker
