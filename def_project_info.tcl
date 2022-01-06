# This is an automatically generated file used by digilent_vivado_checkout.tcl to set project options
proc set_project_properties_post_create_project {proj_name} {
    set project_obj [get_projects $proj_name]
    set_property "part" "xc7z020clg484-1" $project_obj
    set_property BOARD_PART_REPO_PATHS "${::env(HOME)}/.Xilinx/Vivado/2021.1/xhub/board_store/xilinx_board_store" $project_obj
    set_property "board_part" "avnet.com:zedboard:part0:1.4" $project_obj
    set_property "default_lib" "xil_defaultlib" $project_obj
    set_property "simulator_language" "Mixed" $project_obj
    set_property "target_language" "Verilog" $project_obj

    set repo_path [file normalize [file dirname [info script]]/..]
    add_files -quiet -norecurse $repo_path/src/hdl/vhdl
    add_files -quiet -norecurse $repo_path/src/hdl/verilog
}

proc set_project_properties_pre_add_repo {proj_name} {
    set project_obj [get_projects $proj_name]
    # default nothing
}

proc set_project_properties_post_create_runs {proj_name} {
    set project_obj [get_projects $proj_name]
    # default nothing
}
