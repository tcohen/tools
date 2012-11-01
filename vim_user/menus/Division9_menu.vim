"
" Division9 menu
"

an <silent> 20000.1 &Division9.CD\ <Tab>c:\\Division9Prototype\\Source      :cd c:/Division9Prototype/Source<CR>

" Release
"
an <silent> 20000.100 &Division9.-ReleaseSeparator-                         <Nop>
an <silent> 20000.110 &Division9.&Release.&1-Division9                      :!start c:/Division9Prototype/source/tools/launch_in_release.bat<CR>
an <silent> 20000.140 &Division9.&Release.&4-ZombieTest                     :!start c:/Division9Prototype/source/tools/launch_in_release.bat ZombieTest<CR>
an <silent> 20000.140 &Division9.&Release.&5-ZombieSpawning                 :!start c:/Division9Prototype/source/tools/launch_in_release.bat ZombieSpawning<CR>
an <silent> 20000.140 &Division9.&Release.&6-ZombieDoors                    :!start c:/Division9Prototype/source/tools/launch_in_release.bat ZombieDoors<CR>
an <silent> 20000.140 &Division9.&Release.&7-ZombieTenement                 :!start c:/Division9Prototype/source/tools/launch_in_release.bat ZombieTenement<CR>
an <silent> 20000.140 &Division9.&Release.&8-D9_block03Terry                :!start c:/Division9Prototype/source/tools/launch_in_release.bat D9_block03Terry<CR>

an <silent> 20000.190 &Division9.&Release.&9-Division9Ed                    :!start c:/Division9Prototype/source/tools/editor_in_release.bat <CR>

" Debug
"
an <silent> 20000.200 &Division9.-DebugSeparator-                           <Nop>
an <silent> 20000.210 &Division9.&Debug.&1-Division9                        :!start c:/Division9Prototype/source/tools/launch_in_Debug.bat<CR>
an <silent> 20000.240 &Division9.&Debug.&4-ZombieTest                       :!start c:/Division9Prototype/source/tools/launch_in_Debug.bat ZombieTest<CR>
an <silent> 20000.290 &Division9.&Debug.&0-Division9Ed                      :!start c:/Division9Prototype/source/tools/editor_in_Debug.bat <CR>


" Snapshot
"
an <silent> 20000.310 &Division9.-SnapshotSeparator-                        <Nop>
an <silent> 20000.320 &Division9.&Snapshot.&Division9                       :!start c:/Division9Prototype/builds/snapshot/Division9Prototype.exe<CR>
an <silent> 20000.370 &Division9.&Snapshot.&Division9Ed                     :!start c:/Division9Prototype/builds/snapshot/unrealed.exe<CR>

" Maintenance
"
an <silent> 20000.1010 &Division9.-MaintenanceSeparator-                    <Nop>
an <silent> 20000.1020 &Division9.Edit\ Menu<Tab>(Menu)                     :sp $VIM_USER/menus/Division9_menu.vim<CR>
an <silent> 20000.1030 &Division9.Refresh\ Menu<Tab>(Menu)                  :aunmenu &Division9<Bar>source $VIM_USER/menus/Division9_menu.vim<CR>
