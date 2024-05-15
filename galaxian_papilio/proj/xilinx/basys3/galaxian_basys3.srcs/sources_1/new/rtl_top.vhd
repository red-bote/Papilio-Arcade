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
--   top-level for imported galaxian
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
    signal switches : std_logic_vector(8 downto 0);
    signal reset : std_logic;
begin

    -- active-low shutdown pin
    O_PMODAMP2_SHUTD <= sw(14);
    -- gain pin is driven high there is a 6 dB gain, low is a 12 dB gain 
    O_PMODAMP2_GAIN <= sw(15);

    --
    -- Galaxian switch inputs to top-level (I_SW):
    --  I_SW[8] Coin 2
    --  I_SW[7] Start 2
    --  I_SW[6] Coin 1
    --  I_SW[5] Start 1
    --  I_SW[4] Jump/Shoot
    --  I_SW[3] Right
    --  I_SW[2] Left
    --  I_SW[1] Down
    --  I_SW[0] Up
    --
    switches(4 downto 0) <= JA;
    switches(8 downto 5) <= sw(8 downto 5);

    reset <= btnC;

    u_top : entity work.galaxian_top 
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
        I_SW => switches,
        --
        I_RESET_SWn => reset,
        CLK => clk
    );

end Behavioral;
