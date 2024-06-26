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
--   top-level for imported PACMAN
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
    signal js0 : std_logic_vector(4 downto 0);
    signal reset : std_logic;
begin
    --
    -- TODO: document switches
    --
    --  I_SW(0) 1P Start
    --  I_SW(1) Coin
    --  I_SW(2) Coin
    --  I_SW(3) 2P Start
    --
    js0(0) <= JA(3);
    js0(1) <= JA(2);
    js0(2) <= JA(1);
    js0(3) <= JA(0);
    js0(4) <= JA(4);

    -- active-low shutdown pin
    O_PMODAMP2_SHUTD <= sw(14);
    -- gain pin is driven high there is a 6 dB gain, low is a 12 dB gain 
    O_PMODAMP2_GAIN <= sw(15);

    reset <= btnC;

    u_top : entity work.PACMAN 
    port map (
        O_VIDEO_R => vgaRed,
        O_VIDEO_G => vgaGreen,
        O_VIDEO_B => vgaBlue,
        O_HSYNC => Hsync,
        O_VSYNC => Vsync,
        --
        O_AUDIO_L => O_PMODAMP2_AIN,
        O_AUDIO_R => open,
        --
        I_JOYSTICK_A => js0, -- sw(8 downto 4),
        I_JOYSTICK_B => sw(13 downto 9), -- sw[13] low causes test mode
        --
        I_SW => sw(3 downto 0),
        O_LED => led(2 downto 0),
        --
        I_RESET => reset,
        OSC_IN => clk
    );

end Behavioral;
