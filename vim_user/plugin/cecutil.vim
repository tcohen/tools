" cecutil.vim : save/restore window position
"               save/restore mark position
"               save/restore selected user maps
"  Author:	Charles E. Campbell, Jr.
"  Version:	12
"  Date:	Dec 29, 2005
"
"  Saving Restoring Destroying Marks: {{{1
"       call SaveMark(markname)       let savemark= SaveMark(markname)
"       call RestoreMark(markname)    call RestoreMark(savemark)
"       call DestroyMark(markname)
"       commands: SM RM DM
"
"  Saving Restoring Destroying Window Position: {{{1
"       call SaveWinPosn()        let winposn= SaveWinPosn()
"       call RestoreWinPosn()     call RestoreWinPosn(winposn)
"		\swp : save current window/buffer's position
"		\rwp : restore current window/buffer's previous position
"       commands: SWP RWP
"
" GetLatestVimScripts: 1066 1 :AutoInstall: cecutil.vim
"
" You believe that God is one. You do well. The demons also {{{1
" believe, and shudder. But do you want to know, vain man, that
" faith apart from works is dead?  (James 2:19,20 WEB)

" Load Once: {{{1
if &cp || exists("g:loaded_cecutil")
 finish
endif
let g:loaded_cecutil = "v12"
let s:keepcpo        = &cpo
set cpo&vim
"DechoMsgOn

" -----------------------
"  Public Interface: {{{1
" -----------------------

"  Map Interface: {{{2
if !hasmapto('<Plug>SaveWinPosn')
 map <unique> <Leader>swp <Plug>SaveWinPosn
endif
if !hasmapto('<Plug>RestoreWinPosn')
 map <unique> <Leader>rwp <Plug>RestoreWinPosn
endif
nmap <silent> <Plug>SaveWinPosn		:call SaveWinPosn()<CR>
nmap <silent> <Plug>RestoreWinPosn	:call RestoreWinPosn()<CR>

" Command Interface: {{{2
com -bar -nargs=? SWP	call SaveWinPosn(<q-args>)
com -bar -nargs=? RWP	call RestoreWinPosn(<q-args>)
com -bar -nargs=1 SM	call SaveMark(<q-args>)
com -bar -nargs=1 RM	call RestoreMark(<q-args>)
com -bar -nargs=1 DM	call DestroyMark(<q-args>)

" ---------------------------------------------------------------------
" SaveWinPosn: {{{1
"    let winposn= SaveWinPosn()  will save window position in winposn variable
"    call SaveWinPosn()          will save window position in b:winposn{b:iwinposn}
"    let winposn= SaveWinPosn(0) will *only* save window position in winposn variable (no stacking done)
fun! SaveWinPosn(...)
"  call Dfunc("SaveWinPosn() a:0=".a:0)

  let swline    = line(".")
  let swcol     = col(".")
  let swwline   = winline() - 1
  let swwcol    = virtcol(".") - wincol()
  let savedposn = "call GoWinbufnr(".winbufnr(0).")|silent ".swline
  let savedposn = savedposn."|silent norm! 0z\<cr>"
  if swwline > 0
   let savedposn= savedposn.":silent norm! ".swwline."\<c-y>\<cr>"
  endif
  if swwcol > 0
   let savedposn= savedposn.":silent norm! 0".swwcol."zl\<cr>"
  endif
  let savedposn = savedposn.":silent call cursor(".swline.",".swcol.")\<cr>"

  " save window position in
  " b:winposn_{iwinposn} (stack)
  " only if SaveWinPosn() not used
  if a:0 == 0 || a:1 == ""
   if !exists("b:iwinposn")
   	let b:iwinposn= 1
   else
   	let b:iwinposn= b:iwinposn + 1
   endif
   let b:winposn{b:iwinposn}= savedposn
  endif

"  if exists("b:iwinposn")	 " Decho
"   call Decho("b:winpos{".b:iwinposn."}[".b:winposn{b:iwinposn}."]")
"  else                      " Decho
"   call Decho("b:iwinposn doesn't exist")
"  endif                     " Decho
"  call Dret("SaveWinPosn [".savedposn."]")
  return savedposn
endfun

" ---------------------------------------------------------------------
" RestoreWinPosn: {{{1
fun! RestoreWinPosn(...)
"  call Dfunc("RestoreWinPosn() a:0=".a:0)

  if a:0 == 0 || a:1 == ""
   " use saved window position in b:winposn{b:iwinposn} if it exists
   if exists("b:iwinposn") && exists("b:winposn{b:iwinposn}")
"   	call Decho("using stack b:winposn{".b:iwinposn."}<".b:winposn{b:iwinposn}.">")
	try
     exe "silent! ".b:winposn{b:iwinposn}
	catch /^Vim\%((\a\+)\)\=:E749/
	 " ignore empty buffer error messages
	endtry
    " normally drop top-of-stack by one
    " but while new top-of-stack doesn't exist
    " drop top-of-stack index by one again
	if b:iwinposn >= 1
	 unlet b:winposn{b:iwinposn}
	 let b:iwinposn= b:iwinposn - 1
	 while b:iwinposn >= 1 && !exists("b:winposn{b:iwinposn}")
	  let b:iwinposn= b:iwinposn - 1
	 endwhile
	 if b:iwinposn < 1
	  unlet b:iwinposn
	 endif
	endif
   else
   	echohl WarningMsg
	echomsg "***warning*** need to SaveWinPosn first!"
	echohl None
   endif

  else	 " handle input argument
"   call Decho("using input a:1<".a:1.">")
   " use window position passed to this function
   exe "silent ".a:1
   " remove a:1 pattern from b:winposn{b:iwinposn} stack
   if exists("b:iwinposn")
    let jwinposn= b:iwinposn
    while jwinposn >= 1                     " search for a:1 in iwinposn..1
        if exists("b:winposn{jwinposn}")    " if it exists
         if a:1 == b:winposn{jwinposn}      " and the pattern matches
       unlet b:winposn{jwinposn}            " unlet it
       if jwinposn == b:iwinposn            " if at top-of-stack
        let b:iwinposn= b:iwinposn - 1      " drop stacktop by one
       endif
      endif
     endif
     let jwinposn= jwinposn - 1
    endwhile
   endif
  endif

  " seems to be something odd: vertical motions after RWP
  " cause jump to first column.  Following fixes that
  if wincol() > 1
   silent norm! hl
  elseif virtcol(".") < virtcol("$")
   silent norm! lh
  endif

"  call Dret("RestoreWinPosn")
endfun

" ---------------------------------------------------------------------
" GoWinbufnr: go to window holding given buffer (by number) {{{1
"   Prefers current window; if its buffer number doesn't match,
"   then will try from topleft to bottom right
fun! GoWinbufnr(bufnum)
"  call Dfunc("GoWinbufnr(".a:bufnum.")")
  if winbufnr(0) == a:bufnum
"   call Dret("GoWinbufnr : winbufnr(0)==a:bufnum")
   return
  endif
  winc t
  let first=1
  while winbufnr(0) != a:bufnum && (first || winnr() != 1)
  	winc w
	let first= 0
   endwhile
"  call Dret("GoWinbufnr")
endfun

" ---------------------------------------------------------------------
" SaveMark: sets up a string saving a mark position. {{{1
"           For example, SaveMark("a")
"           Also sets up a global variable, g:savemark_{markname}
fun! SaveMark(markname)
"  call Dfunc("SaveMark(markname<".a:markname.">)")
  let markname= a:markname
  if strpart(markname,0,1) !~ '\a'
   let markname= strpart(markname,1,1)
  endif
"  call Decho("markname=".markname)

  let lzkeep  = &lz
  set lz

  if 1 <= line("'".markname) && line("'".markname) <= line("$")
   let winposn               = SaveWinPosn(0)
   exe "keepjumps silent norm! `".markname
   let savemark              = SaveWinPosn(0)
   let g:savemark_{markname} = savemark
   let savemark              = markname.savemark
   call RestoreWinPosn(winposn)
  else
   let g:savemark_{markname} = ""
   let savemark              = ""
  endif

  let &lz= lzkeep

"  call Dret("SaveMark : savemark<".savemark.">")
  return savemark
endfun

" ---------------------------------------------------------------------
" RestoreMark: {{{1
"   call RestoreMark("a")  -or- call RestoreMark(savemark)
fun! RestoreMark(markname)
"  call Dfunc("RestoreMark(markname<".a:markname.">)")

  if strlen(a:markname) <= 0
"   call Dret("RestoreMark : no such mark")
   return
  endif
  let markname= strpart(a:markname,0,1)
  if markname !~ '\a'
   " handles 'a -> a styles
   let markname= strpart(a:markname,1,1)
  endif
"  call Decho("markname=".markname." strlen(a:markname)=".strlen(a:markname))

  let lzkeep  = &lz
  set lz
  let winposn = SaveWinPosn(0)

  if strlen(a:markname) <= 2
   if exists("g:savemark_{markname}") && strlen(g:savemark_{markname}) != 0
	" use global variable g:savemark_{markname}
"	call Decho("use savemark list")
	call RestoreWinPosn(g:savemark_{markname})
	exe "norm! m".markname
   endif
  else
   " markname is a savemark command (string)
"	call Decho("use savemark command")
   let markcmd= strpart(a:markname,1)
   call RestoreWinPosn(markcmd)
   exe "norm! m".markname
  endif

  call RestoreWinPosn(winposn)
  let &lz       = lzkeep

"  call Dret("RestoreMark")
endfun

" ---------------------------------------------------------------------
" DestroyMark: {{{1
"   call DestroyMark("a")  -- destroys mark
fun! DestroyMark(markname)
"  call Dfunc("DestroyMark(markname<".a:markname.">)")
  let markname= strpart(a:markname,0,1)
  if markname !~ '\a'
   " handles 'a -> a styles
   let markname= strpart(a:markname,1,1)
  endif
"  call Decho("markname=".markname)

  let lzkeep  = &lz
  set lz
  let curmod  = &mod
  let winposn = SaveWinPosn(0)
  1
  let lineone = getline(".")
  exe "k".markname
  d
  put! =lineone
  let &mod    = curmod
  call RestoreWinPosn(winposn)
  let &lz     = lzkeep

"  call Dret("DestroyMark")
endfun

"" ---------------------------------------------------------------------
"" ListWinPosn:
"fun! ListWinPosn()
"  if !exists("b:iwinposn")
"   call Decho("LWP: iwinposn doesn't exist")
"   return
"  endif
"  let jwinposn= b:iwinposn
"  while jwinposn >= 1
"   if exists("b:winposn{jwinposn}")
"    call Decho("winposn{".jwinposn."}<".b:winposn{jwinposn}.">")
"   else
"    call Decho("winposn{".jwinposn."} -- doesn't exist")
"   endif
"   let jwinposn= jwinposn - 1
"  endwhile
"endfun
"com! -nargs=0 LWP	call ListWinPosn()

" ---------------------------------------------------------------------
" SaveUserMaps: this function sets up a script-variable (s:restoremap) {{{1
"          which can be used to restore user maps later with
"          call RestoreUserMaps()
"
"          mapmode - see :help maparg for its list
"                    ex. "n" = Normal
"          mapchx  - "<something>" handled as a single map item.
"                    ex. "<left>"
"                  - "string" a string of single letters which are actually
"                    multiple two-letter maps (using the maplead:
"                    maplead . each_character_in_string)
"                    ex. maplead="\" and mapchx="abc" saves mappings for
"                        \a, \b, and \c
"                    Of course, if maplead is "", then for mapchx="abc",
"                    mappings for a, b, and c are saved.
"                  - :something  handled as a single map item, w/o the ":"
"                    ex.  mapchx= ":abc" will save a mapping for "abc"
"          suffix  - a string unique to your plugin
"                    ex.  suffix= "DrawIt"
fun! SaveUserMaps(mapmode,maplead,mapchx,suffix)
"  call Dfunc("SaveUserMaps(mapmode<".a:mapmode."> maplead<".a:maplead."> mapchx<".a:mapchx."> suffix<".a:suffix.">)")

  if !exists("s:restoremap_{a:suffix}")
   let s:restoremap_{a:suffix}= ""
  endif
 
  if strpart(a:mapchx,0,1) == ':'
   " save single map :...something...
   let amap= strpart(a:mapchx,1)
   if amap == "|" || amap == "\<c-v>"
    let amap= "\<c-v>".amap
   endif
   if maparg(amap,a:mapmode) != ""
   	let oldrestore              = s:restoremap_{a:suffix}
   	let s:restoremap_{a:suffix} = a:mapmode."map ".amap." ".maparg(amap,a:mapmode)."|".s:restoremap_{a:suffix}
   	let v:errmsg     = ''
    exe "silent! ".a:mapmode."unmap ".amap
	if v:errmsg != ''
	 let s:restoremap_{a:suffix}= oldrestore
	endif
   endif
   let s:restoremap_{a:suffix} = "silent! ".a:mapmode."unmap ".amap."|".s:restoremap_{a:suffix}
 
  elseif strpart(a:mapchx,0,1) == '<'
   " save single map <something>
   let amap       = a:mapchx
   if amap == "|" || amap == "\<c-v>"
    let amap= "\<c-v>".amap
   endif
   if maparg(a:mapchx,a:mapmode) != ""
   	let oldrestore = s:restoremap_{a:suffix}
   	let s:restoremap_{a:suffix} = a:mapmode."map ".amap." ".maparg(amap,a:mapmode)."|".s:restoremap_{a:suffix}
   	let v:errmsg     = ''
    exe "silent! ".a:mapmode."unmap ".amap
	if v:errmsg != ''
	 let s:restoremap_{a:suffix}= oldrestore
	endif
   endif
   let s:restoremap_{a:suffix} = "silent! ".a:mapmode."unmap ".amap."|".s:restoremap_{a:suffix}
 
  else
   " save multiple maps
   let i= 1
   while i <= strlen(a:mapchx)
    let amap= a:maplead.strpart(a:mapchx,i-1,1)
	if amap == "|" || amap == "\<c-v>"
	 let amap= "\<c-v>".amap
	endif
    if maparg(amap,a:mapmode) != ""
   	 let oldrestore              = s:restoremap_{a:suffix}
   	 let v:errmsg                = ''
   	 let s:restoremap_{a:suffix} = a:mapmode."map ".amap." ".maparg(amap,a:mapmode)."|".s:restoremap_{a:suffix}
     exe a:mapmode."unmap ".amap
     if v:errmsg != ''
      let s:restoremap_{a:suffix}= oldrestore
     endif
    endif
    let s:restoremap_{a:suffix} = "silent! ".a:mapmode."unmap ".amap."|".s:restoremap_{a:suffix}
    let i= i + 1
   endwhile
  endif
"  call Dret("SaveUserMaps : restoremap_".a:suffix.": ".s:restoremap_{a:suffix})
endfun

" ---------------------------------------------------------------------
" RestoreUserMaps: {{{1
"   Used to restore user maps saved by SaveUserMaps()
fun! RestoreUserMaps(suffix)
"  call Dfunc("RestoreUserMaps(suffix<".a:suffix.">)")
  if exists("s:restoremap_{a:suffix}")
   if s:restoremap_{a:suffix} != ""
"   	call Decho("exe ".s:restoremap_{a:suffix})
    exe s:restoremap_{a:suffix}
   endif
   unlet s:restoremap_{a:suffix}
  endif
"  call Dret("RestoreUserMaps")
endfun

" ---------------------------------------------------------------------
"  Restore: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo

" ---------------------------------------------------------------------
"  Modelines: {{{1
" vim: ts=4 fdm=marker
