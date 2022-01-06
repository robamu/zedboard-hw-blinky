----------------------------------------------------------------------------------
-- Company:
-- Engineer: Robin Mueller
--
-- Create Date: 01/03/2022 01:33:49 AM
-- Design Name: Testbench for debounce.vhd
-- Module Name: debounce_tb - Behavioral
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

entity debounce_tb is
end debounce_tb;

architecture Behavioral of debounce_tb is
    -- 100 MHz
    constant CLK_MHZ: positive:= 100_000_000;

    constant HALF_PERIOD: time := (1 * 100_000_0000 / CLK_MHZ / 2) * 1000 * 1 ps;
    -- Declare component which will be tested
    component debouncer is
    generic(
        count_max: positive
    );
    port(
        clk: in std_logic;
        input: in std_logic;
        output: out std_logic
    );
    end component;

    signal finished : std_logic := '0';

    signal clk: std_logic := '0';
    signal input: std_logic := '0';
    signal output: std_logic := '0';

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
    dut: debouncer
    generic map(
        count_max => 5
    )
    port map (
        clk => clk,
        input => input,
        output => output
    );
    -- Clock
    clk <= not clk after HALF_PERIOD when finished /= '1' else '0';

    stimuli : process
    begin
        wait until falling_edge(clk);
        input <= '1';
        wait_cycles_falling_edge(10);
        input <= '0';
        wait_cycles_falling_edge(10);
        -- Simulate bouncy input
        input <= '1';
        wait_cycles_falling_edge(3);
        input <= '0';
        wait_cycles_falling_edge(1);
        input <= '1';
        wait_cycles_falling_edge(2);
        input <= '0';
        finished <= '1';
        wait until finished = '1';
        report "Simulation is finished";
        finish;
    end process;
end Behavioral;
