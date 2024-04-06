[Papilio FPGA](http://papilio.cc/index.php?n=Papilio.PapilioArcade) projects ported to Vivado.


cd Papilio-Arcade_RB/pacman_rel004_sp3e_papilio/romgen_source/
g++ romgen.cpp -o romgen
cd Papilio-Arcade_RB/pacman_rel004_sp3e_papilio/scripts/
./build_roms_pacman.sh

Open .xise file in ISE e.g. _./galaxian_papilio/build/galaxian_papilio_duo_lx9_computing_shield.xise_
Locate top-level RTL file in project hierarchy, righ-click Generate Programming File and select Run.

Program bit file onto board: `papilio-prog  -f ./pacman_rel004_sp3e_papilio/build/PACMAN.bit`


