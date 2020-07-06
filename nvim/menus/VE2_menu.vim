"
" VE2 menu
"

an <silent> 20000.1 VE&2.CD\ <Tab>c:\\VE2\\Source               :cd c:/VE2/Source<CR>

" Release
"
an <silent> 20000.100 VE&2.-ReleaseSeparator-                   <Nop>
an <silent> 20000.110 VE&2.&Release.&1-VE2                      :!start c:/VE2/source/tools/launch_in_release.bat<CR>

an <silent> 20000.190 VE&2.&Release.&9-Division9Ed              :!start c:/VE2/source/tools/editor_in_release.bat <CR>

" Debug
"
an <silent> 20000.200 VE&2.-DebugSeparator-                     <Nop>
an <silent> 20000.210 VE&2.&Debug.&1-VE2                        :!start c:/VE2/source/tools/launch_in_Debug.bat<CR>

" Maintenance
"
an <silent> 20000.1010 VE&2.-MaintenanceSeparator-              <Nop>
an <silent> 20000.1020 VE&2.Edit\ Menu<Tab>(Menu)               :sp $VIM_USER/menus/VE2_menu.vim<CR>
an <silent> 20000.1030 VE&2.Refresh\ Menu<Tab>(Menu)            :aunmenu VE&2<Bar>source $VIM_USER/menus/VE2_menu.vim<CR>
