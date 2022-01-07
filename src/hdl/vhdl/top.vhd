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
    btnU: in std_logic;
    btnL: in std_logic;
    btnC: in std_logic;
    btnR: in std_logic;
    btnD: in std_logic;
    led: out std_logic
);
end top;

architecture Behavioral of top is
    constant dbnc_max_cycles: positive := 15;

    -- Switch register
    signal r_switch: std_logic := '0';
begin
    -- Instantiate all modules

    -- Debouncers
    dbncU: entity work.debouncer
        generic map(
            count_max => dbnc_max_cycles
        )
        port map (
            clk => clk,
            input => btnU,
            output => dbncd_u
        );
    dbncL: entity work.debouncer
        generic map(
            count_max => dbnc_max_cycles
        )
        port map (
            clk => clk,
            input => btnL,
            output => dbncd_l
        );
    dbncC: entity work.debouncer
        generic map(
            count_max => dbnc_max_cycles
        )
        port map (
            clk => clk,
            input => btnC,
            output => dbncd_c
        );
    dbncR: entity work.debouncer
        generic map(
            count_max => dbnc_max_cycles
        )
        port map (
            clk => clk,
            input => btnR,
            output => dbncd_r
        );
    dbncD: entity work.debouncer
        generic map(
            count_max => dbnc_max_cycles
        )
        port map (
            clk => clk,
            input => btnD,
            output => dbncd_d
        );

    -- Button Concat
    btn_concat: entity work.btn_concat
        port map(
            btn_u_dbncd => dbncd_u,
            btn_l_dbncd => dbncd_l,
            btn_r_dbncd => dbncd_r,
            btn_d_dbncd => dbncd_d,
            btn_cncd => blinky_sel
        );

    btn_mux: entity work.btn_mux
        port map(
            input => blinky_sel,
            -- 2 select outputs
            clk_sel => clk_sel
        );

    -- Process which uses debounced center button to toggle the enable pin
    -- of the blinky module
    p_enable_switch: process (clk) is
    begin
        if rising_edge(clk) then
            -- Creates a register
            r_switch <= dbncdC;

            -- Logic to detect falling edge
            if dbncdC = '0' and r_switch = '1' then
                enable_switch <= not enable_switch;
            end if;
        end if;
    end process;

    -- HW Blinky Module
    blinky: entity work.blinky
        generic map(
            clk_freq_mhz => 100
        )
        port map(
            i_clock => clk,
            i_enable => enable_switch,
            i_switch => clk_sel,
            o_led_drive => led
        );
end Behavioral;
