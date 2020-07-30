#!/bin/bash

###########
# Script to create custom es_systems.cfg
# This is to set custom system order or hide systems from Emulation Station without having to manually edit es_systems.cfg
###########

backup_time=$(date +%m-%d-%y_%H-%M) #Custom time used to create es_systems.cfg backup file
es_restore=no #Set to yes if es_systems backup is created.  Used so script knows if there is a file to restore on error
full_list='|'
for LIST in /home/${USER}/RetroPie/roms/*; do if [ -d "${LIST}" ]; then if [ ! -L "${LIST}" ]; then full_list="${LIST##*/}|${full_list}";fi; fi; done
full_list="|${full_list}"

#Set colors for status message
red='\e[1;31m'
yellow='\e[1;33m'
blue='\e[1;34m'
green='\e[1;32m'
white='\e[1;97m'
clear='\e[0m'

backupES_SYSTEMS(){
  es_restore=yes
  cp /home/${USER}/.emulationstation/es_systems.cfg /home/${USER}/.emulationstation/es_systems.cfg.${backup_time}.bkp \
  && echo "Backup \"/home/${USER}/.emulationstation/es_systems.cfg.${backup_time}.bkp\" created!"
}

getSYSTEM_LIST(){
  echo -e "\nEnter order and only systems you want to appear in Emulation Station.  Include ${white}retropie${clear} to add the RetroPie menu.\nValid installed systems are:\n"
  echo -e "${yellow}$(echo ${full_list}|tr '|' " ")${clear}\n"
  read system_list
}

confirmSYSTEM_LIST(){
  clear
  echo -e "Creating custom systems list for ${blue}${system_list}${clear}, do you want to proceed?\n[yes|no|quit]"
  read answer
  getANSWER
}

getANSWER(){
  case $answer in
     y|Y|yes|Yes|YES)
          validateSYSTEM
          ;;
     n|N|no|No|NO|q|Q|quit|Quit|QUIT)
          echo -e "No changes have been made and any backups created have been removed."
          echo -e "To run again please enter ${blue}$0${clear} and hit return."
          rm /home/${USER}/.emulationstation/es_systems.cfg.${backup_time}.bkp 2&>/dev/null
          exit 0
          ;;
     *)
          clear
          echo -e "${red}$answer${clear} is an invalid choice.  Please re-run ${blue}$0${clear} and try again."
          exit 0
          ;;
  esac
}

validateSYSTEM(){
  echo -e "${blue}Validating systems...${clear}"
  for validate in $(echo ${system_list})
  do
    if [[ ! $(echo "${full_list}"|grep "|${validate}|") ]]
    then
      clear
      echo -e "${red}${validate}${clear} is an invalid system!  Please re-run ${blue}${0}${clear} to try again."
      rm /home/${USER}/.emulationstation/es_systems.cfg.${backup_time}.bkp 2&>/dev/null
      exit 0
    fi
  done
  echo -e "Exiting ${blue}Emulation Station${clear}"
  kill $(ps -ef|grep '/opt/retropie/supplementary/emulationstation-dev/emulationstation'|grep -v grep|tail -1|awk '{print $2}')
}

systemLINE(){
case ${system} in
ags)
 name='ags'
 fullname='Adventure Game Studio'
 path='/home/pi/RetroPie/roms/ags'
 extension='.exe .EXE'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ ags %ROM%'
 platform='ags'
 theme='ags'
;;

amstradcpc)
 name='amstradcpc'
 fullname='Amstrad CPC'
 path='/home/pi/RetroPie/roms/amstradcpc'
 extension='.cdt .cpc .dsk .zip .CDT .CPC .DSK .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ amstradcpc %ROM%'
 platform='amstradcpc'
 theme='amstradcpc'
;;

apple2)
 name='apple2'
 fullname='Apple II'
 path='/home/pi/RetroPie/roms/apple2'
 extension='.po .dsk .nib .PO .DSK .NIB'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ apple2 %ROM%'
 platform='apple2'
 theme='apple2'
;;

arcade)
 name='arcade'
 fullname='Arcade'
 path='/home/pi/RetroPie/roms/arcade'
 extension='.7z .cue .fba .iso .zip .7Z .CUE .FBA .ISO .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ arcade %ROM%'
 platform='arcade'
 theme='arcade'
;;

atari2600)
 name='atari2600'
 fullname='Atari 2600'
 path='/home/pi/RetroPie/roms/atari2600'
 extension='.7z .a26 .bin .rom .zip .gz .7Z .A26 .BIN .ROM .ZIP .GZ'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ atari2600 %ROM%'
 platform='atari2600'
 theme='atari2600'
;;

atari5200)
 name='atari5200'
 fullname='Atari 5200'
 path='/home/pi/RetroPie/roms/atari5200'
 extension='.7z .a52 .bin .car .zip .7Z .A52 .BIN .CAR .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ atari5200 %ROM%'
 platform='atari5200'
 theme='atari5200'
;;

atari7800)
 name='atari7800'
 fullname='Atari 7800 ProSystem'
 path='/home/pi/RetroPie/roms/atari7800'
 extension='.7z .a78 .bin .zip .7Z .A78 .BIN .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ atari7800 %ROM%'
 platform='atari7800'
 theme='atari7800'
;;

atari800)
 name='atari800'
 fullname='Atari 800'
 path='/home/pi/RetroPie/roms/atari800'
 extension='.7z .atr .atr.gz .atx .bas .bin .car .cas .com .dcm .rom .xex .xfd .xfd.gz .zip .7Z .ATR .ATR.GZ .ATX .BAS .BIN .CAR .CAS .COM .DCM .ROM .XEX .XFD .XFD.GZ .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ atari800 %ROM%'
 platform='atari800'
 theme='atari800'
;;

atarilynx)
 name='atarilynx'
 fullname='Atari Lynx'
 path='/home/pi/RetroPie/roms/atarilynx'
 extension='.7z .lnx .zip .7Z .LNX .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ atarilynx %ROM%'
 platform='atarilynx'
 theme='atarilynx'
;;

atarist)
 name='atarist'
 fullname='Atari ST'
 path='/home/pi/RetroPie/roms/atarist'
 extension='.st .stx .img .rom .raw .ipf .ctr .zip .ST .STX .IMG .ROM .RAW .IPF .CTR .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ atarist %ROM%'
 platform='atarist'
 theme='atarist'
;;

c64)
 name='c64'
 fullname='Commodore 64'
 path='/home/pi/RetroPie/roms/c64'
 extension='.crt .d64 .g64 .prg .t64 .tap .x64 .zip .vsf .CRT .D64 .G64 .PRG .T64 .TAP .X64 .ZIP .VSF'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ c64 %ROM%'
 platform='c64'
 theme='c64'
;;

coco)
 name='coco'
 fullname='TRS-80 Color Computer'
 path='/home/pi/RetroPie/roms/coco'
 extension='.cas .wav .bas .asc .dmk .jvc .os9 .dsk .vdk .rom .ccc .sna .CAS .WAV .BAS .ASC .DMK .JVC .OS9 .DSK .VDK .ROM .CCC .SNA'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ coco %ROM%'
 platform='coco'
 theme='coco'
;;

coleco)
 name='coleco'
 fullname='ColecoVision'
 path='/home/pi/RetroPie/roms/coleco'
 extension='.bin .col .rom .zip .BIN .COL .ROM .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ coleco %ROM%'
 platform='colecovision'
 theme='colecovision'
;;

dragon32)
 name='dragon32'
 fullname='Dragon 32'
 path='/home/pi/RetroPie/roms/dragon32'
 extension='.cas .wav .bas .asc .dmk .jvc .os9 .dsk .vdk .rom .ccc .sna .CAS .WAV .BAS .ASC .DMK .JVC .OS9 .DSK .VDK .ROM .CCC .SNA'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ dragon32 %ROM%'
 platform='dragon32'
 theme='dragon32'
;;

dreamcast)
 name='dreamcast'
 fullname='Dreamcast'
 path='/home/pi/RetroPie/roms/dreamcast'
 extension='.cdi .chd .cue .gdi .sh .zip .CDI .CHD .CUE .GDI .SH .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ dreamcast %ROM%'
 platform='dreamcast'
 theme='dreamcast'
;;

fba)
 name='fba'
 fullname='Final Burn Alpha'
 path='/home/pi/RetroPie/roms/fba'
 extension='.7z .cue .fba .iso .zip .7Z .CUE .FBA .ISO .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ fba %ROM%'
 platform='arcade'
 theme='fba'
;;

fds)
 name='fds'
 fullname='Famicom Disk System'
 path='/home/pi/RetroPie/roms/fds'
 extension='.7z .nes .fds .zip .7Z .NES .FDS .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ fds %ROM%'
 platform='fds'
 theme='fds'
;;

gameandwatch)
 name='gameandwatch'
 fullname='Game and Watch'
 path='/home/pi/RetroPie/roms/gameandwatch'
 extension='.mgw .MGW'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ gameandwatch %ROM%'
 platform='gameandwatch'
 theme='gameandwatch'
;;

gamegear)
 name='gamegear'
 fullname='Sega Gamegear'
 path='/home/pi/RetroPie/roms/gamegear'
 extension='.7z .gg .bin .sms .zip .7Z .GG .BIN .SMS .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ gamegear %ROM%'
 platform='gamegear'
 theme='gamegear'
;;

gb)
 name='gb'
 fullname='Game Boy'
 path='/home/pi/RetroPie/roms/gb'
 extension='.7z .gb .zip .7Z .GB .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ gb %ROM%'
 platform='gb'
 theme='gb'
;;

gba)
 name='gba'
 fullname='Game Boy Advance'
 path='/home/pi/RetroPie/roms/gba'
 extension='.7z .gba .zip .7Z .GBA .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ gba %ROM%'
 platform='gba'
 theme='gba'
;;

gbc)
 name='gbc'
 fullname='Game Boy Color'
 path='/home/pi/RetroPie/roms/gbc'
 extension='.7z .gbc .zip .7Z .GBC .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ gbc %ROM%'
 platform='gbc'
 theme='gbc'
;;

intellivision)
 name='intellivision'
 fullname='Intellivision'
 path='/home/pi/RetroPie/roms/intellivision'
 extension='.7z .bin .int .itv .rom .zip .7Z .BIN .INT .ITV .ROM .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ intellivision %ROM%'
 platform='intellivision'
 theme='intellivision'
;;

macintosh)
 name='macintosh'
 fullname='Apple Macintosh'
 path='/home/pi/RetroPie/roms/macintosh'
 extension='.txt .dsk .TXT .DSK'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ macintosh %ROM%'
 platform='macintosh'
 theme='macintosh'
;;

mame-advmame)
 name='mame-advmame'
 fullname='Multiple Arcade Machine Emulator'
 path='/home/pi/RetroPie/roms/mame-advmame'
 extension='.zip .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ mame-advmame %ROM%'
 platform='arcade'
 theme='mame'
;;

mame-libretro)
 name='mame-libretro'
 fullname='Multiple Arcade Machine Emulator'
 path='/home/pi/RetroPie/roms/mame-libretro'
 extension='.zip .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ mame-libretro %ROM%'
 platform='arcade'
 theme='mame'
;;

mame-mame4all)
 name='mame-mame4all'
 fullname='Multiple Arcade Machine Emulator'
 path='/home/pi/RetroPie/roms/mame-mame4all'
 extension='.zip .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ mame-mame4all %ROM%'
 platform='arcade'
 theme='mame'
;;

mastersystem)
 name='mastersystem'
 fullname='Sega Master System'
 path='/home/pi/RetroPie/roms/mastersystem'
 extension='.7z .sms .bin .zip .7Z .SMS .BIN .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ mastersystem %ROM%'
 platform='mastersystem'
 theme='mastersystem'
;;

megadrive)
 name='megadrive'
 fullname='Sega Mega Drive'
 path='/home/pi/RetroPie/roms/megadrive'
 extension='.7z .smd .bin .gen .md .sg .zip .7Z .SMD .BIN .GEN .MD .SG .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ megadrive %ROM%'
 platform='megadrive'
 theme='megadrive'
;;

msx)
 name='msx'
 fullname='MSX'
 path='/home/pi/RetroPie/roms/msx'
 extension='.rom .mx1 .mx2 .col .dsk .zip .m3u .ROM .MX1 .MX2 .COL .DSK .ZIP .M3U'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ msx %ROM%'
 platform='msx'
 theme='msx'
;;

n64)
 name='n64'
 fullname='Nintendo 64'
 path='/home/pi/RetroPie/roms/n64'
 extension='.z64 .n64 .v64 .zip .Z64 .N64 .V64 .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ n64 %ROM%'
 platform='n64'
 theme='n64'
;;

neogeo)
 name='neogeo'
 fullname='Neo Geo'
 path='/home/pi/RetroPie/roms/neogeo'
 extension='.7z .chd .cue .fba .iso .zip .7Z .CHD .CUE .FBA .ISO .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ neogeo %ROM%'
 platform='neogeo'
 theme='neogeo'
;;

nes)
 name='nes'
 fullname='Nintendo Entertainment System'
 path='/home/pi/RetroPie/roms/nes'
 extension='.7z .nes .zip .7Z .NES .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ nes %ROM%'
 platform='nes'
 theme='nes'
;;

ngp)
 name='ngp'
 fullname='Neo Geo Pocket'
 path='/home/pi/RetroPie/roms/ngp'
 extension='.7z .ngp .zip .7Z .NGP .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ ngp %ROM%'
 platform='ngp'
 theme='ngp'
;;

ngpc)
 name='ngpc'
 fullname='Neo Geo Pocket Color'
 path='/home/pi/RetroPie/roms/ngpc'
 extension='.7z .ngc .zip .7Z .NGC .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ ngpc %ROM%'
 platform='ngpc'
 theme='ngpc'
;;

pc)
 name='pc'
 fullname='PC'
 path='/home/pi/RetroPie/roms/pc'
 extension='.bat .com .exe .sh .conf .BAT .COM .EXE .SH .CONF'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ pc %ROM%'
 platform='pc'
 theme='pc'
;;

pcengine)
 name='pcengine'
 fullname='PC Engine'
 path='/home/pi/RetroPie/roms/pcengine'
 extension='.7z .pce .ccd .chd .cue .zip .7Z .PCE .CCD .CHD .CUE .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ pcengine %ROM%'
 platform='pcengine'
 theme='pcengine'
;;

ports)
 name='ports'
 fullname='Ports'
 path='/home/pi/RetroPie/roms/ports'
 extension='.sh .SH'
 command='bash %ROM%'
 platform='pc'
 theme='ports'
;;

psp)
 name='psp'
 fullname='PlayStation Portable'
 path='/home/pi/RetroPie/roms/psp'
 extension='.iso .pbp .cso .ISO .PBP .CSO'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ psp %ROM%'
 platform='psp'
 theme='psp'
;;

psx)
 name='psx'
 fullname='PlayStation'
 path='/home/pi/RetroPie/roms/psx'
 extension='.cue .cbn .chd .img .iso .m3u .mdf .pbp .toc .z .znx .CUE .CBN .CHD .IMG .ISO .M3U .MDF .PBP .TOC .Z .ZNX'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ psx %ROM%'
 platform='psx'
 theme='psx'
;;

samcoupe)
 name='samcoupe'
 fullname='SAM Coupe'
 path='/home/pi/RetroPie/roms/samcoupe'
 extension='.dsk .mgt .sbt .sad .DSK .MGT .SBT .SAD'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ samcoupe %ROM%'
 platform='samcoupe'
 theme='samcoupe'
;;

scummvm)
 name='scummvm'
 fullname='ScummVM'
 path='/home/pi/RetroPie/roms/scummvm'
 extension='.sh .svm .SH .SVM'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ scummvm %ROM%'
 platform='scummvm'
 theme='scummvm'
;;

sega32x)
 name='sega32x'
 fullname='Sega 32X'
 path='/home/pi/RetroPie/roms/sega32x'
 extension='.7z .32x .smd .bin .md .zip .7Z .32X .SMD .BIN .MD .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ sega32x %ROM%'
 platform='sega32x'
 theme='sega32x'
;;

segacd)
 name='segacd'
 fullname='Mega CD'
 path='/home/pi/RetroPie/roms/segacd'
 extension='.iso .cue .chd .ISO .CUE .CHD'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ segacd %ROM%'
 platform='segacd'
 theme='segacd'
;;

sg-1000)
 name='sg-1000'
 fullname='Sega SG-1000'
 path='/home/pi/RetroPie/roms/sg-1000'
 extension='.7z .sg .bin .zip .7Z .SG .BIN .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ sg-1000 %ROM%'
 platform='sg-1000'
 theme='sg-1000'
;;

snes)
 name='snes'
 fullname='Super Nintendo'
 path='/home/pi/RetroPie/roms/snes'
 extension='.7z .bin .bs .smc .sfc .fig .swc .mgd .zip .7Z .BIN .BS .SMC .SFC .FIG .SWC .MGD .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ snes %ROM%'
 platform='snes'
 theme='snes'
;;

stratagus)
 name='stratagus'
 fullname='Stratagus Strategy Engine'
 path='/home/pi/RetroPie/roms/stratagus'
 extension='.wc1 .wc2 .sc .data  .WC1 .WC2 .SC .DATA '
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ stratagus %ROM%'
 platform='stratagus'
 theme='stratagus'
;;

vectrex)
 name='vectrex'
 fullname='Vectrex'
 path='/home/pi/RetroPie/roms/vectrex'
 extension='.7z .vec .gam .bin .zip .7Z .VEC .GAM .BIN .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ vectrex %ROM%'
 platform='vectrex'
 theme='vectrex'
;;

videopac)
 name='videopac'
 fullname='Videopac'
 path='/home/pi/RetroPie/roms/videopac'
 extension='.7z .bin .zip .7Z .BIN .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ videopac %ROM%'
 platform='videopac'
 theme='videopac'
;;

virtualboy)
 name='virtualboy'
 fullname='Virtual Boy'
 path='/home/pi/RetroPie/roms/virtualboy'
 extension='.7z .vb .zip .7Z .VB .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ virtualboy %ROM%'
 platform='virtualboy'
 theme='virtualboy'
;;

wonderswan)
 name='wonderswan'
 fullname='Wonderswan'
 path='/home/pi/RetroPie/roms/wonderswan'
 extension='.7z .ws .zip .7Z .WS .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ wonderswan %ROM%'
 platform='wonderswan'
 theme='wonderswan'
;;

wonderswancolor)
 name='wonderswancolor'
 fullname='Wonderswan Color'
 path='/home/pi/RetroPie/roms/wonderswancolor'
 extension='.7z .wsc .zip .7Z .WSC .ZIP'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ wonderswancolor %ROM%'
 platform='wonderswancolor'
 theme='wonderswancolor'
;;

zmachine)
 name='zmachine'
 fullname='Z-machine'
 path='/home/pi/RetroPie/roms/zmachine'
 extension='.dat .zip .z1 .z2 .z3 .z4 .z5 .z6 .z7 .z8 .DAT .ZIP .Z1 .Z2 .Z3 .Z4 .Z5 .Z6 .Z7 .Z8'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ zmachine %ROM%'
 platform='zmachine'
 theme='zmachine'
;;

zxspectrum)
 name='zxspectrum'
 fullname='ZX Spectrum'
 path='/home/pi/RetroPie/roms/zxspectrum'
 extension='.7z .sh .sna .szx .z80 .tap .tzx .gz .udi .mgt .img .trd .scl .dsk .zip .rzx .7Z .SH .SNA .SZX .Z80 .TAP .TZX .GZ .UDI .MGT .IMG .TRD .SCL .DSK .ZIP .RZX'
 command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ zxspectrum %ROM%'
 platform='zxspectrum'
 theme='zxspectrum'
;;
esac
}

######
# Script starts here
######

clear

#Check for custom es_systems.cfg and create backup if it exists
if [[ -f /home/${USER}/.emulationstation/es_systems.cfg ]]
then
  backupES_SYSTEMS
fi

#Read default /etc/emulationstation/es_systems.cfg to generate list of valid systems
getSYSTEM_LIST

#Confirm user choice
confirmSYSTEM_LIST

#Create es_systems.cfg
clear
echo -e "${blue}Generating ${white}\"/home/${USER}/.emulationstation/es_systems.cfg\"${clear}"
echo '<systemList>' > /home/${USER}/.emulationstation/es_systems.cfg
for system in $(echo ${system_list})
do
echo -e "${white}${system} added${clear}"
systemLINE
echo -e "  <system>\r
    <name>${name}</name>\r
    <fullname>${fullname}</fullname>\r
    <path>${path}</path>\r
    <extension>${extension}</extension>\r
    <command>${command}</command>\r
    <platform>${platform}</platform>\r
    <theme>${theme}</theme>\r
  </system>" >> /home/${USER}/.emulationstation/es_systems.cfg
done
echo '</systemList>' >> /home/${USER}/.emulationstation/es_systems.cfg

if [[ ${es_restore} == yes ]]
then
echo -e "\n${blue}/home/${USER}/.emulationstation/es_systems.cfg.${backup_time}.bkp${clear} has been created.\n
To revert changes in the future exit Emulation Station and run:\r
${yellow}cat /home/${USER}/.emulationstation/es_systems.cfg.${backup_time}.bkp > /home/${USER}/.emulationstation/es_systems.cfg${clear}"
fi
echo -e "\nTo remove ALL custom system list and revert to default run:"
echo -e "${yellow}rm /home/${USER}/.emulationstation/es_systems.cfg${clear}\n"
echo -e "Would you like to ${red}reboot${clear} to enable the new custom systems list? [YES|NO]"
read reboot_question
case ${reboot_question} in
  y|Y|yes|Yes|YES)
    sudo reboot
  ;;
  *)
    echo -e "\n[YES] not chosen, exiting script.  Please run \"${red}sudo reboot${clear}\" or \"${blue}emulationstation${clear}\" to use new es_systems.cfg list"
    exit 0
  ;;
esac
