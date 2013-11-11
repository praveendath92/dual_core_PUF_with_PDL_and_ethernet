
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name ethernet -dir "E:/Dropbox/Works and collections/Elec/Rice/Joonho/codes/dual_core_PUF_with_PDL_and_ethernet/planAhead_run_2" -part xc5vlx110tff1136-1
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "E:/Dropbox/Works and collections/Elec/Rice/Joonho/codes/dual_core_PUF_with_PDL_and_ethernet/system.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {E:/Dropbox/Works and collections/Elec/Rice/Joonho/codes/dual_core_PUF_with_PDL_and_ethernet} {ipcore_dir} }
add_files [list {ipcore_dir/blk_mem_gen_inputMem.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/blk_mem_gen_outputMem.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/blk_mem_gen_paramReg.ncf}] -fileset [get_property constrset [current_run]]
set_property target_constrs_file "XUPV5system.ucf" [current_fileset -constrset]
add_files [list {XUPV5system.ucf}] -fileset [get_property constrset [current_run]]
open_netlist_design