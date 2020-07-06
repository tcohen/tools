"
" SWAT menu
"

" Release
"
an <silent> 10000.1 SW&AT.&Release.&1-Swat4                            :!start c:/swat4/source/tools/launch_in_release.bat<CR>
an <silent> 10000.2 SW&AT.&Release.&2-SP-Hotel                         :!start c:/swat4/source/tools/launch_in_release.bat SP-Hotel<CR>
an <silent> 10000.3 SW&AT.&Release.&3-tmcGroupedClasses                :!start c:/swat4/source/tools/launch_in_release.bat tmcGroupedClasses<CR>
an <silent> 10000.4 SW&AT.&Release.&4-ClearTest                        :!start c:/swat4/source/tools/launch_in_release.bat ClearTest<CR>
an <silent> 10000.5 SW&AT.&Release.&5-SP-FoodWall                      :!start c:/swat4/source/tools/launch_in_release.bat SP-FoodWall<CR>
an <silent> 10000.6 SW&AT.&Release.&6-tmcDoorsTest                     :!start c:/swat4/source/tools/launch_in_release.bat tmcDoorsTest<CR>
an <silent> 10000.7 SW&AT.&Release.&7-SP-FairfaxResidence              :!start c:/swat4/source/tools/launch_in_release.bat SP-FairfaxResidence<CR>
an <silent> 10000.8 SW&AT.&Release.&8-SP-Training                      :!start c:/swat4/source/tools/launch_in_release.bat SP-Training<CR>
an <silent> 10000.9 SW&AT.&Release.&9-UnrealEd                         :!start c:/swat4/source/tools/editor_in_release.bat <CR>
an <silent> 10000.10 SW&AT.&Release.&10-NetServer                         :!start c:/swat4/source/tools/run_server_in_release.bat <CR>
an <silent> 10000.10 SW&AT.&Release.&11-NetClient                         :!start c:/swat4/source/tools/run_client_in_release.bat <CR>

" Debug
"
an <silent> 10000.100 SW&AT.-DebugSeparator-                            <Nop>
an <silent> 10000.110 SW&AT.&Debug.&1-Swat4                             :!start c:/swat4/source/tools/launch_in_Debug.bat<CR>
an <silent> 10000.120 SW&AT.&Debug.&2-tmcOfficeTest2                    :!start c:/swat4/source/tools/launch_in_Debug.bat tmcOfficeTest2<CR>
an <silent> 10000.130 SW&AT.&Debug.&3-SpecialObjectivesTest             :!start c:/swat4/source/tools/launch_in_Debug.bat SpecialObjectivesTest<CR>
an <silent> 10000.140 SW&AT.&Debug.&4-MPTest2                           :!start c:/swat4/source/tools/launch_in_Debug.bat MPTest2<CR>
an <silent> 10000.150 SW&AT.&Debug.&5-SP-Foodwall                       :!start c:/swat4/source/tools/launch_in_Debug.bat SP-Foodwall<CR>
an <silent> 10000.160 SW&AT.&Debug.&6-tmcDoorsTest                      :!start c:/swat4/source/tools/launch_in_Debug.bat tmcDoorsTest<CR>
an <silent> 10000.170 SW&AT.&Debug.&7-SpecialObjectivesTest             :!start c:/swat4/source/tools/launch_in_Debug.bat SpecialObjectivesTest<CR>
an <silent> 10000.180 SW&AT.&Debug.&8-SP-Training                       :!start c:/swat4/source/tools/launch_in_Debug.bat SP-Training<CR>
an <silent> 10000.190 SW&AT.&Debug.&0-UnrealEd                          :!start c:/swat4/source/tools/editor_in_Debug.bat <CR>

" SP-Demo Release
"
an <silent> 10000.200 SW&AT.-SPDemoReleaseSeparator-                            <Nop>
an <silent> 10000.210 SW&AT.&SPDemoRelease.&1-Swat4                            :!start c:/Swat4Branches/SPDemo/source/tools/launch_in_release.bat<CR>
an <silent> 10000.220 SW&AT.&SPDemoRelease.&2-SP-Hotel                         :!start c:/Swat4Branches/SPDemo/source/tools/launch_in_release.bat SP-Hotel<CR>
an <silent> 10000.230 SW&AT.&SPDemoRelease.&3-tmcGroupedClasses                :!start c:/Swat4Branches/SPDemo/source/tools/launch_in_release.bat tmcGroupedClasses<CR>
an <silent> 10000.240 SW&AT.&SPDemoRelease.&4-ClearTest                        :!start c:/Swat4Branches/SPDemo/source/tools/launch_in_release.bat ClearTest<CR>
an <silent> 10000.250 SW&AT.&SPDemoRelease.&5-SP-FoodWall                      :!start c:/Swat4Branches/SPDemo/source/tools/launch_in_release.bat SP-FoodWall<CR>
an <silent> 10000.260 SW&AT.&SPDemoRelease.&6-tmcDoorsTest                     :!start c:/Swat4Branches/SPDemo/source/tools/launch_in_release.bat tmcDoorsTest<CR>
an <silent> 10000.270 SW&AT.&SPDemoRelease.&7-SP-FairfaxResidence              :!start c:/Swat4Branches/SPDemo/source/tools/launch_in_release.bat SP-FairfaxResidence<CR>
an <silent> 10000.280 SW&AT.&SPDemoRelease.&8-SP-Training                      :!start c:/Swat4Branches/SPDemo/source/tools/launch_in_release.bat SP-Training<CR>
an <silent> 10000.290 SW&AT.&SPDemoRelease.&0-UnrealEd                         :!start c:/Swat4Branches/SPDemo/source/tools/editor_in_release.bat <CR>

" Snapshot
"
an <silent> 10000.310 SW&AT.-SnapshotSeparator-                     <Nop>
an <silent> 10000.320 SW&AT.&Snapshot.&Swat4                        :!start c:/swat4/builds/snapshot/swat4.exe<CR>
an <silent> 10000.330 SW&AT.&Snapshot.&tmcTraining                  :!start c:/swat4/builds/snapshot/swat4.exe tmcTraining<CR>
an <silent> 10000.340 SW&AT.&Snapshot.&tmcDoorsTest                 :!start c:/swat4/builds/snapshot/swat4.exe tmcDoorsTest<CR>
an <silent> 10000.350 SW&AT.&Snapshot.&tmcOfficeTest2               :!start c:/swat4/builds/snapshot/swat4.exe tmcOfficeTest2<CR>
an <silent> 10000.370 SW&AT.&Snapshot.&UnrealEd                     :!start c:/swat4/builds/snapshot/unrealed.exe<CR>

" Maintenance
"
an <silent> 10000.1010 SW&AT.-MaintenanceSeparator-                 <Nop>
an <silent> 10000.1020 SW&AT.Edit\ Menu<Tab>(Menu)                  :sp $VIM_USER/menus/SWAT_menu.vim<CR>
an <silent> 10000.1030 SW&AT.Refresh\ Menu<Tab>(Menu)               :aunmenu SW&AT<Bar>source $VIM_USER/menus/SWAT_menu.vim<CR>
