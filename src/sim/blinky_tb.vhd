----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Robin Mueller
-- 
-- Create Date: 01/03/2022 01:33:49 AM
-- Design Name: Testbench for blinky.vhd
-- Module Name: blinky_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use std.env.finish;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity blinky_tb is
--  Port ( );
end blinky_tb;

architecture Behavioral of blinky_tb is
    -- 100 MHz
    constant CLK_MHZ: positive:= 100_000_000;

    constant HALF_PERIOD: time := (1 * 100_000_0000 / CLK_MHZ / 2) * 1000 * 1 ps;
    -- Declare component which will be tested
    component blinky is
    generic(
        clk_freq_mhz: positive
    );
    port(
        i_clock: in std_logic;
        i_enable: in std_logic;
        i_switch_0: in std_logic;
        i_switch_1: in std_logic;
        o_led_drive: out std_logic
    );
    end component;

    signal finished : std_logic := '0';

    signal clk: std_logic := '0';
    signal i_switch_0: std_logic := '0';
    signal i_switch_1: std_logic := '0';
    signal led: std_logic := '0';
    signal i_enable: std_logic := '0';
begin
   -- Instantiate design-under-test
    dut: blinky
    generic map(
        clk_freq_mhz => 100
    )
    port map (
        i_clock => clk,
        i_enable => i_enable,
        i_switch_0 => i_switch_0,
        i_switch_1 => i_switch_1,
        o_led_drive => led
    );
    -- Clock
    clk <= not clk after HALF_PERIOD when finished /= '1' else '0';
    stimuli : process
    begin
        -- Enable LED driving. LED has duty cycle of 50 %
        i_enable <= '1';
        -- 1 Hz
        i_switch_0 <= '0';
        i_switch_1 <= '0';
        wait for 1100ms;
        -- 10 Hz
        i_switch_0 <= '0';
        i_switch_1 <= '1';
        wait for 150ms;
        -- 50 Hz
        i_switch_0 <= '1';
        i_switch_1 <= '0';
        wait for 50ms;
        -- 100 Hz
        i_switch_0 <= '1';
        i_switch_1 <= '1';
        wait for 50ms;
        -- Signal finish
        finished <= '1';
        wait until finished = '1';
        report "Simulation is finished";
        finish;
    end process;
end Behavioral;
