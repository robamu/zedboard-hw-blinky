----------------------------------------------------------------------------------
-- Company:
-- Engineer: Robin Mueller
--
-- Create Date: 01/07/2022 04:49:02 PM
-- Design Name: Button Debouncer
-- Module Name: debouncer - Behavioral
-- Project Name: ZedBoard HW Blinky
-- Target Devices: ZedBoard
-- Tool Versions: Vivado 2021.2
-- Description: Top HW blinky VHDL module. Wires all submodules together
--
-- Dependencies:
--  - debouncer module
--  - blinky module
--  - btn_mux module
--  - btn_concat module
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
port(
	-- Port definitions are mapped to external hardware in constraints file
	clk: in std_logic;
	btnR: in std_logic;
	btnC: in std_logic;
	btnD: in std_logic;
	btnL: in std_logic;
	btnU: in std_logic
);
end top;

architecture Behavioral of top is

begin


end Behavioral;
