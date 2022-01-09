----------------------------------------------------------------------------------
-- Company:
-- Engineer: Robin Mueller
--
-- Create Date: 01/03/2022 01:55:28 PM
-- Design Name:
-- Module Name: btn_enable_toggle - Behavioral
-- Project Name: ZedBoard HW Blinky
-- Target Devices: ZedBoard
-- Tool Versions: Vivado 2021.2
-- Description: Convert center button signal to enable signal toggler
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

entity btn_enable_toggle is
port(
	i_clock: in std_logic;
	i_btn_dbncd: in std_logic;
	o_enb_switch: out std_logic
);
end btn_enable_toggle;

architecture Behavioral of btn_enable_toggle is
	-- Register definitions.
    signal r_enb_switch: std_logic := '0';
    signal r_current: std_logic := '0';
begin
    -- Process which uses debounced center button to toggle the enable pin
    -- of the blinky module
    p_enable_switch: process (i_clock) is
    begin
        o_enb_switch <= r_current;

        if rising_edge(i_clock) then
            -- Creates a register
            r_enb_switch <= i_btn_dbncd;

            -- Logic to detect falling edge
            if i_btn_dbncd = '0' and r_enb_switch = '1' then
                r_current <= not r_current;
            end if;
        end if;
    end process;
end Behavioral;
