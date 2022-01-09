ZedBoard HW Blinky Project
=======

This is the adaption of the [nandland LED blinky](https://www.nandland.com/vhdl/tutorials/tutorial-your-first-vhdl-program-part1.html)
project to the [ZedBoard](https://www.avnet.com/wps/portal/us/products/avnet-boards/avnet-board-families/zedboard/).

It also includes a set of testbenches for various of the used modules and for the top module.
There are two possible ways to generate the hardware:

- Using the block design which can be loaded with the `src/bd/hw_blinky.tcl` file
- Using the top design `src/hdl/vhdl/top.vhd`. It is loaded during project generation

Set one of those two options as the top design before generating the bitstream.

## Prerequisites

1. Python 3 installation (> 3.8)
2. Recent Vivado version. This project was implemented using Vivado 2021.1 and Vivado 2021.2

## Generating the project

The project files can be generated for a given Vivado version by performing the
following steps

1. Copy the `def_project_info.tcl` file to `project_info.tcl`

   ```sh
   cp def_project_info.tcl project_info.tcl
   ```

2. Adapt the file to your needs. For example, you can set the `BOARD_PART_REPO_PATHS`
   to wherever the downloaded board files are located

3. Copy the `config.ini` file in `digilent-vivado-scripts` to the repository root

   ```sh
   cp digilent-vivado-scripts/config.ini config.ini
   ```

4. Adapt the `config.ini` file to your needs. You can also set the default Vivado version
   here

5. Generate the project with the `git_vivado.py` script

   ```sh
   cd digilent-vivado-scripts
   ./git-vivado checkout
   ```

6. If the project was generated sucessfully, you can find the `zedboard-hw-blinky.xpr`
   Vivado project file in the `proj` folder. Open this file in Vivado.

## Flashing the project onto the ZedBoard

Requires that the project was generated.

1. Open the project with Vivado
2. Generate the bitstream
3. Use the hardware manager in Vivado to flash the board
