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

entity top is
port(
    -- Port definitions are mapped to external hardware in constraints file
    GCLK: in std_logic;
    BTNU: in std_logic;
    BTNL: in std_logic;
    BTNC: in std_logic;
    BTNR: in std_logic;
    BTND: in std_logic;
    LD0: out std_logic
);
end top;

architecture Behavioral of top is
    constant dbnc_max_cycles: positive := 5;

    -- Switch register
    signal r_enb_switch: std_logic := '0';
    signal r_clk_sel: std_logic_vector(0 to 1) := "00";
    signal w_dbncd_u: std_logic;
    signal w_dbncd_l: std_logic;
    signal w_dbncd_r: std_logic;
    signal w_dbncd_d: std_logic;
    signal w_dbncd_c: std_logic;
    signal w_clk_sel: std_logic_vector(0 to 1);
    signal w_enb_switch: std_logic := '0';
begin
    -- Instantiate all modules

    -- Button Debouncers
    p_dbnc_u: entity work.debouncer
        generic map(
            count_max => dbnc_max_cycles
        )
        port map (
            i_clock => GCLK,
            input => BTNU,
            output => w_dbncd_u
        );
    p_dbnc_l: entity work.debouncer
        generic map(
            count_max => dbnc_max_cycles
        )
        port map (
            i_clock => GCLK,
            input => BTNL,
            output => w_dbncd_l
        );
    p_dbnc_c: entity work.debouncer
        generic map(
            count_max => dbnc_max_cycles
        )
        port map (
            i_clock => GCLK,
            input => BTNC,
            output => w_dbncd_c
        );
    p_dbnc_r: entity work.debouncer
        generic map(
            count_max => dbnc_max_cycles
        )
        port map (
            i_clock => GCLK,
            input => BTNR,
            output => w_dbncd_r
        );
    p_dbnc_d: entity work.debouncer
        generic map(
            count_max => dbnc_max_cycles
        )
        port map (
            i_clock => GCLK,
            input => BTND,
            output => w_dbncd_d
        );

    -- Implements clock select from button press sources
    p_btn_to_clksel: entity work.btn_to_clksel
        port map(
            i_clock => GCLK,
            i_btn_u_dbncd => w_dbncd_u,
            i_btn_l_dbncd => w_dbncd_l,
            i_btn_r_dbncd => w_dbncd_r,
            i_btn_d_dbncd => w_dbncd_d,
            o_clk_sel => w_clk_sel
        );

    -- Process which uses debounced center button to toggle the enable pin
    -- of the blinky module
    p_enable_switch: process (GCLK) is
    begin
        if rising_edge(GCLK) then
            -- Creates a register
            r_enb_switch <= w_dbncd_c;

            -- Logic to detect falling edge
            if w_dbncd_c = '0' and r_enb_switch = '1' then
                w_enb_switch <= not w_enb_switch;
            end if;
        end if;
    end process;

    -- HW Blinky Module
    blinky: entity work.blinky
        generic map(
            clk_freq_mhz => 100
        )
        port map(
            i_clock => GCLK,
            i_enable => w_enb_switch,
            i_switch => w_clk_sel,
            o_led_drive => LD0
        );
end Behavioral;
