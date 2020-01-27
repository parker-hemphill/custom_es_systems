#!/bin/bash

###########
# Script to create custom es_systems.cfg
# This is to set custom system order or hide systems from Emulation Station without having to manually edit es_systems.cfg
###########

backup_time=$(date +%m-%d-%y_%H-%M) #Custom time used to create es_systems.cfg backup file
es_restore=no #Set to yes if es_systems backup is created.  Used so script knows if there is a file to restore on error
full_list="|$(grep '<name>' /etc/emulationstation/es_systems.cfg|sed -e 's/    <name>//g' -e 's/<\/name>//g'|tr "\n" "|")" #List of valid systems installed in RetroPie

#Set colors for status message
red='\e[1;31m'
yellow='\e[1;33m'
blue='\e[1;34m'
green='\e[1;32m'
white='\e[1;97m'
clear='\e[0m'

backupES_SYSTEMS(){
  es_restore=yes
  cp /home/$USER/.emulationstation/es_systems.cfg /home/$USER/.emulationstation/es_systems.cfg.$backup_time.bkp \
  && echo "Backup \"/home/$USER/.emulationstation/es_systems.cfg.$backup_time.bkp\" created!"
}

getSYSTEM_LIST(){
  echo -e "\nEnter order and only systems you want to appear in Emulation Station.  Include ${white}retropie${clear} to add the RetroPie menu.\nValid installed systems are:\n"
  echo -e "${yellow}$(echo $full_list|tr '|' " ")${clear}\n"
  read system_list
}

confirmSYSTEM_LIST(){
  clear
  echo -e "Creating custom systems list for ${blue}$system_list${clear}, do you want to proceed?\n[yes|no|quit]"
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
          rm /home/$USER/.emulationstation/es_systems.cfg.$backup_time.bkp 2&>/dev/null
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
  for validate in $(echo $system_list)
  do
    if [[ ! $(echo "$full_list"|grep "|$validate|") ]]
    then
      clear
      echo -e "${red}$validate${clear} is an invalid system!  Please re-run ${blue}$0${clear} to try again."
      rm /home/$USER/.emulationstation/es_systems.cfg.$backup_time.bkp 2&>/dev/null
      exit 0
    fi
  done
  echo -e "Exiting ${blue}Emulation Station${clear}"
  kill $(ps -ef|grep '/opt/retropie/supplementary/emulationstation-dev/emulationstation'|grep -v grep|tail -1|awk '{print $2}')
}

systemLINE(){
case $system in
amstradcpc)
  name='amstradcpc'
  fullname='Amstrad CPC'
  path="/home/$USER/RetroPie/roms/amstradcpc"
  extension='.cdt .cpc .dsk .zip .CDT .CPC .DSK .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ amstradcpc %ROM%'
  platform='amstradcpc'
  theme='amstradcpc'
;;
arcade)
  name='arcade'
  fullname='Arcade'
  path="/home/$USER/RetroPie/roms/arcade"
  extension='.7z .cue .fba .iso .zip .7Z .CUE .FBA .ISO .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ arcade %ROM%'
  platform='arcade'
  theme='arcade'
;;
atari2600)
  name='atari2600'
  fullname='Atari 2600'
  path="/home/$USER/RetroPie/roms/atari2600"
  extension='.7z .a26 .bin .rom .zip .gz .7Z .A26 .BIN .ROM .ZIP .GZ'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ atari2600 %ROM%'
  platform='atari2600'
  theme='atari2600'
;;
atari5200)
  name='atari5200'
  fullname='Atari 5200'
  path="/home/$USER/RetroPie/roms/atari5200"
  extension='.7z .a52 .bin .car .zip .7Z .A52 .BIN .CAR .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ atari5200 %ROM%'
  platform='atari5200'
  theme='atari5200'
;;
atari7800)
  name='atari7800'
  fullname='Atari 7800 ProSystem'
  path="/home/$USER/RetroPie/roms/atari7800"
  extension='.7z .a78 .bin .zip .7Z .A78 .BIN .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ atari7800 %ROM%'
  platform='atari7800'
  theme='atari7800'
;;
atari800)
  name='atari800'
  fullname='Atari 800'
  path="/home/$USER/RetroPie/roms/atari800"
  extension='.7z .atr .atr.gz .atx .bas .bin .car .cas .com .dcm .rom .xex .xfd .xfd.gz .zip .7Z .ATR .ATR.GZ .ATX .BAS .BIN .CAR .CAS .COM .DCM .ROM .XEX .XFD .XFD.GZ .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ atari800 %ROM%'
  platform='atari800'
  theme='atari800'
;;
atarilynx)
  name='atarilynx'
  fullname='Atari Lynx'
  path="/home/$USER/RetroPie/roms/atarilynx"
  extension='.7z .lnx .zip .7Z .LNX .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ atarilynx %ROM%'
  platform='atarilynx'
  theme='atarilynx'
;;
coleco)
  name='coleco'
  fullname='ColecoVision'
  path="/home/$USER/RetroPie/roms/coleco"
  extension='.bin .col .rom .zip .BIN .COL .ROM .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ coleco %ROM%'
  platform='colecovision'
  theme='colecovision'
;;
fba)
  name='fba'
  fullname='Final Burn Alpha'
  path="/home/$USER/RetroPie/roms/fba"
  extension='.7z .cue .fba .iso .zip .7Z .CUE .FBA .ISO .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ fba %ROM%'
  platform='arcade'
  theme='fba'
;;
fds)
  name='fds'
  fullname='Famicom Disk System'
  path="/home/$USER/RetroPie/roms/fds"
  extension='.7z .nes .fds .zip .7Z .NES .FDS .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ fds %ROM%'
  platform='fds'
  theme='fds'
;;
gamegear)
  name='gamegear'
  fullname='Sega Gamegear'
  path="/home/$USER/RetroPie/roms/gamegear"
  extension='.7z .gg .bin .sms .zip .7Z .GG .BIN .SMS .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ gamegear %ROM%'
  platform='gamegear'
  theme='gamegear'
;;
gb)
  name='gb'
  fullname='Game Boy'
  path="/home/$USER/RetroPie/roms/gb"
  extension='.7z .gb .zip .7Z .GB .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ gb %ROM%'
  platform='gb'
  theme='gb'
;;
gba)
  name='gba'
  fullname='Game Boy Advance'
  path="/home/$USER/RetroPie/roms/gba"
  extension='.7z .gba .zip .7Z .GBA .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ gba %ROM%'
  platform='gba'
  theme='gba'
;;
gbc)
  name='gbc'
  fullname='Game Boy Color'
  path="/home/$USER/RetroPie/roms/gbc"
  extension='.7z .gbc .zip .7Z .GBC .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ gbc %ROM%'
  platform='gbc'
  theme='gbc'
;;
mame-libretro)
  name='mame-libretro'
  fullname='Multiple Arcade Machine Emulator'
  path="/home/$USER/RetroPie/roms/mame-libretro"
  extension='.zip .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ mame-libretro %ROM%'
  platform='arcade'
  theme='mame'
;;
mastersystem)
  name='mastersystem'
  fullname='Sega Master System'
  path="/home/$USER/RetroPie/roms/mastersystem"
  extension='.7z .sms .bin .zip .7Z .SMS .BIN .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ mastersystem %ROM%'
  platform='mastersystem'
  theme='mastersystem'
;;
megadrive)
  name='megadrive'
  fullname='Sega Mega Drive'
  path="/home/$USER/RetroPie/roms/megadrive"
  extension='.7z .smd .bin .gen .md .sg .zip .7Z .SMD .BIN .GEN .MD .SG .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ megadrive %ROM%'
  platform='megadrive'
  theme='megadrive'
;;
msx)
  name='msx'
  fullname='MSX'
  path="/home/$USER/RetroPie/roms/msx"
  extension='.rom .mx1 .mx2 .col .dsk .zip .m3u .ROM .MX1 .MX2 .COL .DSK .ZIP .M3U'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ msx %ROM%'
  platform='msx'
  theme='msx'
;;
n64)
  name='n64'
  fullname='Nintendo 64'
  path="/home/$USER/RetroPie/roms/n64"
  extension='.z64 .n64 .v64 .zip .Z64 .N64 .V64 .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ n64 %ROM%'
  platform='n64'
  theme='n64'
;;
neogeo)
  name='neogeo'
  fullname='Neo Geo'
  path="/home/$USER/RetroPie/roms/neogeo"
  extension='.7z .cue .fba .iso .zip .7Z .CUE .FBA .ISO .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ neogeo %ROM%'
  platform='neogeo'
  theme='neogeo'
;;
nes)
  name='nes'
  fullname='Nintendo Entertainment System'
  path="/home/$USER/RetroPie/roms/nes"
  extension='.7z .nes .zip .7Z .NES .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ nes %ROM%'
  platform='nes'
  theme='nes'
;;
ngp)
  name='ngp'
  fullname='Neo Geo Pocket'
  path="/home/$USER/RetroPie/roms/ngp"
  extension='.7z .ngp .zip .7Z .NGP .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ ngp %ROM%'
  platform='ngp'
  theme='ngp'
;;
ngpc)
  name='ngpc'
  fullname='Neo Geo Pocket Color'
  path="/home/$USER/RetroPie/roms/ngpc"
  extension='.7z .ngc .zip .7Z .NGC .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ ngpc %ROM%'
  platform='ngpc'
  theme='ngpc'
;;
pcengine)
  name='pcengine'
  fullname='PC Engine'
  path="/home/$USER/RetroPie/roms/pcengine"
  extension='.7z .pce .ccd .chd .cue .zip .7Z .PCE .CCD .CHD .CUE .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ pcengine %ROM%'
  platform='pcengine'
  theme='pcengine'
;;
psx)
  name='psx'
  fullname='PlayStation'
  path="/home/$USER/RetroPie/roms/psx"
  extension='.cue .cbn .chd .img .iso .m3u .mdf .pbp .toc .z .znx .CUE .CBN .CHD .IMG .ISO .M3U .MDF .PBP .TOC .Z .ZNX'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ psx %ROM%'
  platform='psx'
  theme='psx'
;;
retropie)
  name='retropie'
  fullname='RetroPie'
  path="/home/$USER/RetroPie/retropiemenu"
  extension='.rp .sh'
  command='sudo /home/pi/RetroPie-Setup/retropie_packages.sh retropiemenu launch %ROM% &lt;/dev/tty &gt;/dev/tty'
  platform=''
  theme='retropie'
;;
sega32x)
  name='sega32x'
  fullname='Sega 32X'
  path="/home/$USER/RetroPie/roms/sega32x"
  extension='.7z .32x .smd .bin .md .zip .7Z .32X .SMD .BIN .MD .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ sega32x %ROM%'
  platform='sega32x'
  theme='sega32x'
;;
segacd)
  name='segacd'
  fullname='Mega CD'
  path="/home/$USER/RetroPie/roms/segacd"
  extension='.iso .cue .chd .ISO .CUE .CHD'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ segacd %ROM%'
  platform='segacd'
  theme='segacd'
;;
sg-1000)
  name='sg-1000'
  fullname='Sega SG-1000'
  path="/home/$USER/RetroPie/roms/sg-1000"
  extension='.7z .sg .bin .zip .7Z .SG .BIN .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ sg-1000 %ROM%'
  platform='sg-1000'
  theme='sg-1000'
;;
snes)
  name='snes'
  fullname='Super Nintendo'
  path="/home/$USER/RetroPie/roms/snes"
  extension='.7z .bin .bs .smc .sfc .fig .swc .mgd .zip .7Z .BIN .BS .SMC .SFC .FIG .SWC .MGD .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ snes %ROM%'
  platform='snes'
  theme='snes'
;;
vectrex)
  name='vectrex'
  fullname='Vectrex'
  path="/home/$USER/RetroPie/roms/vectrex"
  extension='.7z .vec .gam .bin .zip .7Z .VEC .GAM .BIN .ZIP'
  command='/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ vectrex %ROM%'
  platform='vectrex'
  theme='vectrex'
;;
zxspectrum)
  name='zxspectrum'
  fullname='ZX Spectrum'
  path="/home/$USER/RetroPie/roms/zxspectrum"
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
if [[ -f /home/$USER/.emulationstation/es_systems.cfg ]]
then
  backupES_SYSTEMS
fi

#Read default /etc/emulationstation/es_systems.cfg to generate list of valid systems
getSYSTEM_LIST

#Confirm user choice
confirmSYSTEM_LIST

#Create es_systems.cfg
clear
echo -e "${blue}Generating ${white}\"/home/$USER/.emulationstation/es_systems.cfg\"${clear}"
echo '<systemList>' > /home/$USER/.emulationstation/es_systems.cfg
for system in $(echo $system_list)
do
echo -e "${white}$system added${clear}"
systemLINE
echo -e "  <system>\r
    <name>$name</name>\r
    <fullname>$fullname</fullname>\r
    <path>$path</path>\r
    <extension>$extension</extension>\r
    <command>$command</command>\r
    <platform>$platform</platform>\r
    <theme>$theme</theme>\r
  </system>" >> /home/$USER/.emulationstation/es_systems.cfg
done
echo '</systemList>' >> /home/$USER/.emulationstation/es_systems.cfg

if [[ $es_restore == yes ]]
then
echo -e "\n${blue}/home/$USER/.emulationstation/es_systems.cfg.$backup_time.bkp${clear} has been created.\n
To revert changes in the future exit Emulation Station and run:\r
${yellow}cat /home/$USER/.emulationstation/es_systems.cfg.$backup_time.bkp > /home/$USER/.emulationstation/es_systems.cfg${clear}"
fi
echo -e "\nTo remove ALL custom system list and revert to default run:"
echo -e "${yellow}rm /home/$USER/.emulationstation/es_systems.cfg${clear}\n"
echo -e "Would you like to ${red}reboot${clear} to enable the new custom systems list? [YES|NO]"
read reboot_question
case $reboot_question in
  y|Y|yes|Yes|YES)
    sudo reboot
  ;;
  *)
    echo -e "\n[YES] not chosen, exiting script.  Please run \"${red}sudo reboot${clear}\" or \"${blue}emulationstation${clear}\" to use new es_systems.cfg list"
    exit 0
  ;;
esac
