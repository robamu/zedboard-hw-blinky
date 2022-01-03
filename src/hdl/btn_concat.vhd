----------------------------------------------------------------------------------
-- Company:
-- Engineer: Robin Mueller
--
-- Create Date: 01/03/2022 01:55:28 PM
-- Design Name:
-- Module Name: btn_concat - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity btn_concat is
port(
	btn_u_dbncd: in std_logic;
	btn_l_dbncd: in std_logic;
	btn_r_dbncd: in std_logic;
	btn_d_dbncd: in std_logic;
	btn_cncd: out std_logic_vector(0 to 2)
);
end btn_concat;

architecture Behavioral of btn_concat is
begin
	btn_cncd <= btn_u_dbncd & btn_l_dbncd & btn_r_dbncd & btn_u_dbncd;
end Behavioral;
