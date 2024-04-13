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
--   top-level for imported SCRAMBLE
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
    signal buttons : std_logic_vector(3 downto 0);
    signal reset : std_logic;
begin

    -- active-low shutdown pin
    O_PMODAMP2_SHUTD <= sw(14);
    -- gain pin is driven high there is a 6 dB gain, low is a 12 dB gain 
    O_PMODAMP2_GAIN <= sw(15);

    --buttons <= btnL & btnR & btnU & btnD;
    buttons(3) <= btnL;
    buttons(2) <= btnR;
    buttons(1) <= btnU;
    buttons(0) <= btnD;
    reset <= btnC;

    -- Scramble top-level inputs
    -- sw(0)   1 Player Start
    -- sw(1)   Coin In
    -- sw(2)   Fi
    -- sw(3)   2 Player Start
    -- btn(0)
    -- btn(1)
    -- btn(2)
    -- btn(3)

    u_top : entity work.SCRAMBLE_TOP 
    port map (
        O_VIDEO_R => vgaRed,
        O_VIDEO_G => vgaGreen,
        O_VIDEO_B => vgaBlue,
        O_HSYNC => hSync,
        O_VSYNC => vSync,
        --
        O_AUDIO_L => O_PMODAMP2_AIN,
        O_AUDIO_R => open,
        --
        I_SW => sw(3 downto 0),
        I_BUTTON => buttons,
        --JOYSTICK_GND => open,
        --
        I_RESET => reset,
        OSC_IN => clk
    );

end Behavioral;
