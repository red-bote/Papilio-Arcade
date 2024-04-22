[Papilio FPGA](http://papilio.cc/index.php?n=Papilio.PapilioArcade) projects ported to Vivado.

# Basys 3

A new top-level is created to adapt the external I/O for Basys 3 which also includes support for 1-channel sound output to a PMOD AMP2. 

The Papillio boards provided a 33 Mhz oscillator so a new 100 Mhz system clock source has been generated using the Vivado clocking wizard.

A new design source was created in each project e.g. pacman_clocks_xilinx_wiz.vhd. The original code targeted to the Spartan series has a DCM clock which is replaced with componenent instantiation from the Vivado clocking wizard that  generates an MMCM clock module. In addition there is logic to generated the other clock enables required in the design, which is retained fron the original source. 

The component declaration and instantiation templates are copied from the wizard generated file:

`proj/xilinx/basys3/pengopac.gen/sources_1/ip/clk_wiz_0/clk_wiz_0.vho`


```
------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
component clk_wiz_0
port
 (-- Clock in ports
  -- Clock out ports
  clk_out1          : out    std_logic;
  -- Status and control signals
  reset             : in     std_logic;
  locked            : out    std_logic;
  clk_in1           : in     std_logic
 );
end component;

-- COMP_TAG_END ------ End COMPONENT Declaration ------------


------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
your_instance_name : clk_wiz_0
   port map ( 
  -- Clock out ports  
   clk_out1 => clk_out1,
  -- Status and control signals                
   reset => reset,
   locked => locked,
   -- Clock in ports
   clk_in1 => clk_in1
 );
-- INST_TAG_END ------ End INSTANTIATION Template ------------
```

The clock is imported into the project (check _Copy sources into project_): 

`/home/xubuntu/hdl/pacman_rel004_sp3e/proj/xilinx/basys3/pacman.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_clk_wiz.v`

The clok_wiz_0.xci is not kept in the project.

# Papilio

These projects should reatain compatibility with the Papilio hardware (I still have a working Papillio DUO with retro-computing shield so that one at least is known to work). 

```
cd Papilio-Arcade_RB/pacman_rel004_sp3e_papilio/romgen_source/
g++ romgen.cpp -o romgen
cd Papilio-Arcade_RB/pacman_rel004_sp3e_papilio/scripts/
./build_roms_pacman.sh
```

Open .xise file in ISE e.g. _./galaxian_papilio/build/galaxian_papilio_duo_lx9_computing_shield.xise_

Locate top-level RTL file in project hierarchy, right-click _Generate Programming File_ and select _Run_.

Program bit file onto board: 

`papilio-prog  -f ./pacman_rel004_sp3e_papilio/build/PACMAN.bit`


