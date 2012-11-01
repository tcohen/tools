"
" I8_Menu
"

" Favorites
"
an <silent> 1000.30 &I8.SwatGamePlayer&Controller               :sp game/swatgame/classes/SwatGamePlayerController.uc<CR>

" Maintenance
"
an <silent> 1000.1000 &I8.-Separator-                            <Nop>
an <silent> 1000.1010 &I8.&Edit\ Menu<Tab>(Menu)                 :sp $VIM_USER/menus/Favorites_Menu.vim<CR>
an <silent> 1000.1020 &I8.&Refresh\ Menu<Tab>(Menu)              :aunmenu &Favorites<Bar>source $VIM_USER/menus/Favorites_Menu.vim<CR>
