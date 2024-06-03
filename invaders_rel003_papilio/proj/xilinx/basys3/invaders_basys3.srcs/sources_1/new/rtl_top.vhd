----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
--   Red~Bote
-- Create Date: 04/11/2024 07:36:35 PM
-- Design Name: 
-- Module Name: rtl_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
--   top-level for imported invaders
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

entity rtl_top is
    Port ( clk : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           JA : in STD_LOGIC_VECTOR (4 downto 0);
           btnC : in STD_LOGIC;
           btnU : in STD_LOGIC;
           btnL : in STD_LOGIC;
           btnR : in STD_LOGIC;
           btnD : in STD_LOGIC;
           vgaRed : out STD_LOGIC_VECTOR (3 downto 0);
           vgaGreen : out STD_LOGIC_VECTOR (3 downto 0);
           vgaBlue : out STD_LOGIC_VECTOR (3 downto 0);
           Hsync : out STD_LOGIC;
           Vsync : out STD_LOGIC;
           O_PMODAMP2_AIN : out STD_LOGIC;
           O_PMODAMP2_GAIN : out STD_LOGIC;
           O_PMODAMP2_SHUTD : out STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0));
end rtl_top;

architecture Behavioral of rtl_top is
    signal switches : std_logic_vector(7 downto 0);
    signal reset : std_logic;
begin

    -- active-low shutdown pin
    O_PMODAMP2_SHUTD <= sw(14);
    -- gain pin is driven high there is a 6 dB gain, low is a 12 dB gain 
    O_PMODAMP2_GAIN <= sw(15);

    reset <= btnC;

    -- Invaders top-level switch inputs
    -- b(0) -- Nop
    -- b(1) -- Nop
    -- b(2) -- Left
    -- b(3) -- Right
    -- b(4) -- Fire
    -- b(5) -- Player 2 start
    -- b(6) -- Coin
    -- b(7) -- Player 1 start
    switches(0) <= JA(2); -- nop
    switches(1) <= JA(3); -- nop
    switches(2) <= JA(1); -- left
    switches(3) <= JA(0); -- right
    switches(4) <= JA(4); -- fire
    switches(7 downto 5) <= sw(7 downto 5);

    u_top : entity work.invaders_top 
    port map (
        O_VIDEO_R => vgaRed(3),
        O_VIDEO_G => vgaGreen(3),
        O_VIDEO_B => vgaBlue(3),
        O_HSYNC => hSync,
        O_VSYNC => vSync,
        --
        O_AUDIO_L => O_PMODAMP2_AIN,
        O_AUDIO_R => open,
        --
        I_BUTTON => switches,
        --
        I_RESET => reset,
        OSC_IN => clk
    );

end Behavioral;
