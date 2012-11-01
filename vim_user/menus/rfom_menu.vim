"
" R:FoM_Menu
"

" Favorites
"
an <silent> 1000.30 &R:FoM.SwatGamePlayer&Controller               :sp game/swatgame/classes/SwatGamePlayerController.uc<CR>

" Branches
"
"an <silent> 

" Maintenance
"
an <silent> 1000.1000 &R:FoM.-Separator-                            <Nop>
an <silent> 1000.1010 &R:FoM.&Edit\ Menu<Tab>(Menu)                 :sp $VIM/menus/rfom_menu.vim<CR>
an <silent> 1000.1020 &R:FoM.&Refresh\ Menu<Tab>(Menu)              :aunmenu &Favorites<Bar>source $VIM/menus/rfom_menu.vim<CR>
