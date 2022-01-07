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
	i_btn_u_dbncd: in std_logic;
	i_btn_l_dbncd: in std_logic;
	i_btn_r_dbncd: in std_logic;
	i_btn_d_dbncd: in std_logic;
	o_btn_cncd: out std_logic_vector(0 to 1)
);
end btn_concat;

architecture Behavioral of btn_concat is
begin
	o_btn_cncd <= "00" when (
			i_btn_u_dbncd = '1'
			and i_btn_l_dbncd = '0'
			and i_btn_r_dbncd ='0'
			and i_btn_d_dbncd = '0'
		) else "01" when (
			i_btn_u_dbncd = '0'
			and i_btn_l_dbncd = '1'
			and i_btn_r_dbncd ='0'
			and i_btn_d_dbncd = '0'
		) else "10" when (
			i_btn_u_dbncd = '0'
			and i_btn_l_dbncd = '0'
			and i_btn_r_dbncd ='1'
			and i_btn_d_dbncd = '0'
		) else "11" when (
			i_btn_u_dbncd = '0'
			and i_btn_l_dbncd = '0'
			and i_btn_r_dbncd ='0'
			and i_btn_d_dbncd = '1'
		);
end Behavioral;
