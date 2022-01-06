----------------------------------------------------------------------------------
-- Company:
-- Engineer: Robin Mueller
--
-- Create Date: 01/03/2022 01:05:20 PM
-- Design Name: 4-to-2 Multiplexer for 4 buttons
-- Module Name: btn_mux - Behavioral
-- Project Name: Zedboard HW Blinky
-- Target Devices: Zedboard
-- Tool Versions: Vivado 2021.2
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity btn_mux is
--  Port ( );
port(
    -- Debounced button input
    input: in std_logic_vector(0 to 2);
    -- 2 select outputs
    clk_sel: out std_logic_vector(0 to 1)
);
end btn_mux;

architecture Behavioral of btn_mux is
    -- Buttons are used, so the last target output needs to be stored
    signal last_clk_sel: std_logic_vector(0 to 1) := "00";
begin
    last_clk_sel <= "00" when input = "1000" else
        "01" when input = "0100" else
        "10" when input = "0010" else
        "11" when input = "0001";
    clk_sel <= last_clk_sel;
end Behavioral;
