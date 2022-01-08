----------------------------------------------------------------------------------
-- Company:
-- Engineer: Robin Mueller
--
-- Create Date: 01/03/2022 01:55:28 PM
-- Design Name:
-- Module Name: btn_to_clksel - Behavioral
-- Project Name: ZedBoard HW Blinky
-- Target Devices: ZedBoard
-- Tool Versions: Vivado 2021.2
-- Description: Stores the last pressed clock select button and converts it
--     into appropriate select output for the blinky module
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

entity btn_to_clksel is
port(
	i_clock: in std_logic;
	i_btn_u_dbncd: in std_logic;
	i_btn_l_dbncd: in std_logic;
	i_btn_r_dbncd: in std_logic;
	i_btn_d_dbncd: in std_logic;
	o_clk_sel: out std_logic_vector(0 to 1)
);
end btn_to_clksel;

architecture Behavioral of btn_to_clksel is
	-- Register definitions.
	-- Required to detect button press and store clock select state
	signal r_btn_u: std_logic := '0';
	signal r_btn_l: std_logic := '0';
	signal r_btn_r: std_logic := '0';
	signal r_btn_d: std_logic := '0';
	signal r_clk_sel: std_logic_vector(0 to 1) := "00";
begin
	r_btn_u <= i_btn_u_dbncd;
	o_clk_sel <= r_clk_sel;

	p_btn_edge_detect: process(i_clock)
	begin
        if rising_edge(i_clock) then
            -- Logic to detect falling edges
            if i_btn_u_dbncd = '0' and r_btn_u = '1' then
                r_clk_sel <= "00";
            elsif i_btn_l_dbncd = '0' and r_btn_l = '1' then
                r_clk_sel <= "01";
            elsif i_btn_r_dbncd = '0' and r_btn_r = '1' then
                r_clk_sel <= "10";
            elsif i_btn_d_dbncd = '0' and r_btn_d = '1' then
                r_clk_sel <= "11";
            end if;
        end if;
	end process;
end Behavioral;
