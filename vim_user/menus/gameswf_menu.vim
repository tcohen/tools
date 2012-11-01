"
" gameswf menu
"

an <silent> 30000.1 &GameSWF.CD                                         :cd C:/Swat4Branches/working/source/libraries/GameSWF/tu-testbed<CR>

" Maintenance
"
an <silent> 20000.1010 &GameSWF.-MaintenanceSeparator-                    <Nop>
an <silent> 20000.1020 &GameSWF.Edit\ Menu<Tab>(Menu)                     :sp $VIM_USER/menus/gameswf_menu.vim<CR>
an <silent> 20000.1030 &GameSWF.Refresh\ Menu<Tab>(Menu)                  :aunmenu &GameSWF<Bar>source $VIM_USER/menus/gameswf_menu.vim<CR>
