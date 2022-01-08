----------------------------------------------------------------------------------
-- Company:
-- Engineer: Robin Mueller
--
-- Create Date: 01/03/2022 01:33:49 AM
-- Design Name: Testbench for top.vhd
-- Module Name: zedboard_blinky_tb - Behavioral
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

entity zedboard_blinky_tb is
end zedboard_blinky_tb;

architecture Behavioral of zedboard_blinky_tb is
    -- 100 MHz
    constant CLK_MHZ: positive:= 100_000_000;

    constant HALF_PERIOD: time := (1 * 100_000_0000 / CLK_MHZ / 2) * 1000 * 1 ps;

    signal finished : std_logic := '0';
    signal clk: std_logic := '0';

    signal button_1_hz: std_logic := '0';
    signal button_10_hz: std_logic := '0';
    signal button_50_hz: std_logic := '0';
    signal button_100_hz: std_logic := '0';
    signal enb_switch: std_logic := '0';

    signal led: std_logic := '0';

    procedure wait_cycles_falling_edge(
        cycles: positive
    ) is begin
        for idx in 0 to cycles loop
            wait until falling_edge(clk);
        end loop;
    end procedure;

    procedure wait_cycles_rising_edge(
        cycles: positive
    ) is begin
        for idx in 0 to cycles loop
            wait until rising_edge(clk);
        end loop;
    end procedure;

begin
    -- Instantiate design-under-test
    dut: entity work.top
        port map (
            GCLK => clk,
            BTNU => button_1_hz,
            BTNL => button_10_hz,
            BTNC => enb_switch,
            BTNR => button_50_hz,
            BTND => button_100_hz,
            LD0 => led
        );

    -- Clock
    clk <= not clk after HALF_PERIOD when finished /= '1' else '0';

    stimuli : process
    begin
        -- Use higher frequency, easier to simulate
        -- Simulate a button press to enable the blinky module and select higher frequency
        enb_switch <= '1';
        button_100_hz <= '1';
        wait_cycles_falling_edge(20);
        enb_switch <= '0';
        button_100_hz <= '0';
        wait_cycles_falling_edge(20);
        wait for 20ms;
        -- Signal finish
        finished <= '1';
        wait until finished = '1';
        report "Simulation is finished";
        finish;
    end process;
end Behavioral;
