# Testing

This file is in french as all our beta testers are french.


A chaque modification du système, les développeurs ajoutent une ou plusieurs lignes dans ce fichier.

Les beta testeurs cochent les cases lors des sessions de tests.

Toutes les cases doivent être cochées avant la release stable.

Pour les pending features, elles ne seront activées que si les beta testeurs les valident selon les critères de qualité de Recalbox.

## [Next]

## Pending Features
- [ ] Test & evaluate MelonDS on Pi4 : NOk - rame trop sur Pi non O/C
- [ ] GameClip => Test gameclip screensaver with some available videos => Test all options
- [ ] GameClip => Test gameclip screensaver with no video (fresh install?) or by selecting only systems with no videos at all
- [ ] New slides during install => Fresh install on all patforms. All platforms must show the 8 slides, except on GPI which keeps the "creating share" video
- [ ] Test & evaluate libretro-mupen64plus-next on odroidxu4
- [ ] Add Super Cassette Vision core => Test this core and report bugs/improvements to Maaax
- [ ] Add libretro neocd core => test this core with cue/bin, cue/iso and chd
- [ ] Test Nintendo switch joycons and combined joycons
- [ ] DosBox Pure added => test this new core
- [ ] Pulseaudio - Check audio works everywhere and switch automatically when new output (jack, bluetooth) is connected

## Non Regression
- [ ] Réécriture des menus => vérifier l'affichage, et le fonctionnement de chaque entrée dans les menus recalbox
- [ ] Amiberry Bump => Deeply retest amiberry: test all rom types, check default configuration, ...
- [ ] Port Bump => xrick, tyrquake, reminiscense, prboom, mrboom, ecwolf, dinothawr, 2048 : test all cores
- [ ] New roms management => Test option in game menu to show/hide preinstalled games
- [ ] New roms management => Fresh install: Test all ports
- [ ] Added rpi-400 dts => check pi400 boots correctly
- [ ] mupen64plus bump => test standalone core deeply on all boards
- [ ] Enabled mupen64plus with rice for odroidgo2 => test it works thoroughly
- [ ] Check that mupen64plus standalone with gliden64 fully works on rpi2 and rpi3
- [ ] Bump Stella => Deeply retest Stella core
- [ ] BR2020.11 - Check hyperion still works (ian57 a le matos)
- [ ] BR2020.11 - Test libretro-fmsx
- [ ] BR2020.11 - Test libretro-mupen64plus-nx on rpi2 (as libretro-mupen64plus is disabled)
- [ ] BR2020.11 - Test libretro-gpsp
- [ ] BR2020.11 - Test advancemame
- [ ] BR2020.11 - Test libretro-mu
- [ ] BR2020.11 - Check libretro-pcsx_rearmed works properly (bumped)
- [ ] BR2020.11 - Test moonlight-embedded
- [ ] BR2020.11 - Test openbor
- [ ] BR2020.11 - Test mpv (splash video) still works
- [ ] BR2020.11 - Test ppsspp
- [ ] BR2020.11 - Test libretro-81
- [ ] BR2020.11 - Check reicast has no significant slowdown (compiled without lto)
- [ ] BR2020.11 - Test libretro-flycast
- [ ] Verify wm8960 audio hat works for all boards with kernel 5.4 (ian57 a le matos)
- [ ] BR2020.11 - Check splash video on rpi1, 2 and 3
- [ ] BR2020.11 - Check xu4 works perfectly (freeze, video problem, usb problem). Check `dmesg` for errors
- [ ] BR2020.11 - Check reicast-old has no significant slowdown on Odroid XU4(compiled without lto)
- [ ] BR2020.11 - Check that Odroid GO2 boots correctly
- [ ] BR2020.11 - Check that PC with intel chipsets works properly
- [ ] BR2020.11 - Check Xorg AMDGPU driver works properly (see with david)
- [ ] BR2020.11 - Check Xorg OpenChrome driver works properly (see with david)
- [ ] BR2020.11 - Check libretro-mame works properly (0.226)
- [ ] BR2020.11 - Check libretro-melonds works properly
- [ ] BR2020.11 - Test pcsx_rearmed on rpi1 works
- [ ] Test rtl8189fs, rtl8821au and rtl88x2bu wifi drivers work properly on rpi1, rpi2, odroidxu4, x86 and x86_64
- [ ] BR2020.11 - Check nvidia drivers version 390 works properly
- [ ] BR2020.11 - Check nvidia drivers version 440 works properly
- [ ] BR2020.11 - Check bluetooth pairing
- [ ] BR2020.11 - Check PC Legacy boot works (GRUB loading... boot loop)
- [ ] Bump Hatari => Retest all game format on Atari ST core
- [ ] RB should start successfully on any video output of the rpi4 (hdmi0 or hdmi1, switching needs reboot)
- [ ] Headphone output should be selectable in ES on rpi4
- [ ] Offline/online upgrade still works (check config.txt and recalbox-user-config.txt)
  - [ ] begin an upgrade download and remove ethernet cable while download => no upgrade + clean files
  - [ ] begin an upgrade download and poweroff during the download => no upgrade + clean files
  - [ ] put an image and a sha1sum file with wrong sha1 sum in /boot => no upgrade + clean files
  - [ ] put an image in share (offline upgrade) => no upgrade
  - [ ] put an image and a sha1sum file with wrong sha1 sum in share => no upgrade
  - [ ] put an image and a sha1sum file with good sha1 sum in share => UPGRADE
  - [ ] check /boot/recalbox-user-config.txt exists and /boot/config.txt includes it (rpi only)
  - [ ] add or change a parameter in /boot/recalbox-user-config.txt and check it is taken into account (rpi only)
- [ ] Pulseaudio - Check audio works in PPSSPP (#1511)
  - [ ] Check if recalbox can connect on open network (passwordless SSID)
- [ ] Check 8Bitdo SN30 pro / SF30 pro mapping
- [ ] Check Palmos palmos52-en-t3.rom is correctly recognized

## Technique
- [ ] Packages that require libgo2 compiles well
- [ ] /usr/lib/libgo2.so should provides go2_ symbols
- [ ] Validate libretro-mupen64plus-next compiles on all boards
- [ ] BR2020.11 - Test kodi-audiodecoder-timidity (how ?)
- [ ] BR2020.11 - Check that kernel patchs are applied on linux and (cutom) linux-headers
- [ ] BR2020.11 - Check that hardware works properly on x86 and x86_64 (no kernel and defconfig modified)
- [ ] Test S024kdetector still does its job
- [ ] Check if WPA-PSK-SHA256 key mgmt works (`wpa_cli status |grep -q key_mgmt=WPA2-PSK-SHA256 && echo "OK"`)

## [7.1-Reloaded]
- [X] Bumped picodrive to fix rewind on megadrive => test the rewind on megadrive/picodrive
- [X] Clock should update properly
- [X] Battery icon should show and update properly on PC when battery data are available, especially for a pc with /sys/class/power_supply/BAT1
- [X] Test audio output persistancy in ES => change output, reboot ES, check if still selected, once again
- [X] Check that a P2K file is visible in UI => create a .p2k.cfg file in a rom directory, then check that p2k hints are available for all games in this folder
- [X] Check network menu translations especially for WIFI (ON/OFF/WPS)
- [X] Check regional system logo => switch theme, reboot, check that regionalized logo are shown properly (GB, SNES, ...)
- [X] Fixed the composite MD calculations => Test if neogeozip bios files are giving the same MD5 with different zip compressions
- [X] Kodi executable check => Check if all kodi menu are visible & working on random board, but GO2.
- [X] Kodi executable check => Check if all kodi menu are NOT visible on GO2
- [X] Virtual Keyboard => check if dpad + J1 move the wheel and j2 moves the cursor
- [X] Fixed VIC20 extensions => Run games for VIC20 with any extension but .20 .40 .60 .a0 .b0.
- [X] Fixed scrapper settings not being saved => Set global scrapper settings without running a global scrapping. Instead, run a single game scrapping and check results accordingly
- [X] Fixed gamelist.xml being overwritten when edited from outside ES => Run ES, play a game, edit a gamelist from the network share, wait for ES to detect the change, let Es relaunch, then check if your modification is still there
- [X] Fixed puae kickstart copy => test WHDL with uae
- [X] Fixed puae cd32 & cdtv => run an amiga600 games with UAE, then run a CD32 game, then run a CDTV game (in this exact order). All games must work
- [X] Fixed VK on 1080p and more => Open VK and use DPAD's up & down to change charset several times. No glitches & no messed up screens should occur
- [X] Recalbox is back in Window's Network => Switch on recalbox, wait for ES, wait a few more seconds, a new machine called 'RECALBOX' should pop in your Network
- [X] Flashback core improved => Test flashback
- [X] PSP mapping generator rewritten => Test PSP games with all available pads
- [X] Pi400 support => Boot on Pi400 using Pi4 image
- [X] Check that kodi does not crash upon loading
- [X] Test all broke studio games!

WHDL with PUAE must be deeply tested. Some bioses still don't load.
