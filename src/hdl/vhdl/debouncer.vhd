----------------------------------------------------------------------------------
-- Company:
-- Engineer: Robin Mueller
--
-- Create Date: 01/03/2022 01:07:07 PM
-- Design Name: Button Debouncer
-- Module Name: debouncer - Behavioral
-- Project Name: ZedBoard HW Blinky
-- Target Devices: ZedBoard
-- Tool Versions: Vivado 2021.2
-- Description: Debounces a signal by requiring it to remain stable for
--     a specified amount of cycles
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

entity debouncer is
generic(
    count_max: positive := 15
);
port(
    i_clock: in std_logic;
    i_raw: in std_logic;
    o_dbncd: out std_logic
);
end debouncer;

architecture Behavioral of debouncer is
    type T_ONOFF_STATE is (S_ON, S_OFF);
    type T_STATE is (IDLE, TRANS);
    constant count_max_internal: natural := count_max - 1;

    signal counter: integer range 0 to count_max_internal;
    signal current_state: T_STATE := IDLE;
    signal onoff_state: T_ONOFF_STATE := S_OFF;
begin
    debounce_proc: process(i_clock)
    begin
        if rising_edge(i_clock) then
            if onoff_state = S_ON then
                if current_state = IDLE then
                    if i_raw = '0' then
                        current_state <= TRANS;
                    end if;
                elsif current_state = TRANS then
                    if i_raw = '1' then
                        current_state <= IDLE;
                        counter <= 0;
                    elsif counter = count_max_internal - 1 then
                        onoff_state<= S_OFF;
                        counter <= 0;
                        current_state <= IDLE;
                    else
                        counter <= counter + 1;
                    end if;
                end if;
            elsif onoff_state = S_OFF then
                if current_state = IDLE then
                    if i_raw = '1' then
                        current_state <= TRANS;
                    end if;
                elsif current_state = TRANS then
                    if i_raw = '0' then
                        current_state <= IDLE;
                        counter <= 0;
                    elsif counter = count_max_internal - 1 then
                        onoff_state <= S_ON;
                        counter <= 0;
                        current_state <= IDLE;
                    else
                        counter <= counter + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

    output_proc: process(i_clock)
    begin
        if rising_edge(i_clock) then
            case onoff_state is
                when S_ON => o_dbncd <= '1';
                when S_OFF => o_dbncd <= '0';
            end case;
        end if;
    end process;
end Behavioral;
