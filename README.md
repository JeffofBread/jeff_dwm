# jdwm

A custom build of [dwm](https://dwm.suckless.org/) made by myself, JeffofBread. If you find any issues or would like to make a recommendation, feel free. This is a major work in progress and **will** change.

<img src="https://github.com/JeffofBread/jdwm/blob/screenshots/jdwm_storm.png"> 
<img src="https://github.com/JeffofBread/jdwm/blob/screenshots/jdwm_lush.png">

## Install

**Notes before you install:**
 - Make sure you have all the necessary [required dependencies](#required-dependencies), or issues could occur during installation.
 - For a more custom install process, check install flags (run `./install.sh -h` for more info) and/or edit paths specified at the start of the script.
 - To edit things like your terminal alias before installation, edit `/jdwm/dwm/resources/jdwm.aliases`. This can also be done after installation by going to `~/.config/jdwm/jdwm.aliases`
 - To edit what programs autostart with jdwm copy `/jdwm/dwm/scripts/jdwm_autostarts.example` as `/jdwm/dwm/scripts/jdwm_autostarts.sh` and put whatever commands/programs you want started in there. It will be installed along with other scripts to `/usr/local/bin` and run at login.
 - By default on install, `install.sh` will clone [jdwm' wallpapers branch](https://github.com/JeffofBread/jdwm/tree/wallpapers) into `~/.config/jdwm/wallpapers/`. These wallpapers are used by the themes in `/jdwm/dwm/themes/`. If you are bandwidth or storage limited, you may want to [disable this step in the install script](https://github.com/JeffofBread/jdwm/blob/2785f37afb877c014ec3e551911a805ec216c1cf/install.sh#L235) and remove/alter the wallpaper commands in the various theme files (`/jdwm/dwm/themes/`).

```bash
git clone https://github.com/JeffofBread/jdwm.git
cd jdwm
./install.sh
```

You can also customize your install with installer flags. To see a list of all flags and their purpose, run:

```bash
./install.sh -h
```
```bash
./install.sh --help
```

Below are some examples of how these can be used and combined:

<details><summary><b>Example: Only install jdwm scripts</b></summary>

```bash
./install -js
```
```bash
./install --jdwm-scripts
```
</details>

<details><summary><b>Example: Only install jdwm scripts, dwmblocks scripts, and rofi scripts</b></summary>

```bash
./install -js -bs -rs
```
```bash
./install --jdwm-scripts --dwmblocks-scripts --rofi-scripts
```
</details>

## Uninstall

**Notes before you uninstall:**
 Please make sure you know what is being removed by the script and dont accidentally remove something you intended to keep. The script (by default) will remove all of the what is listed below, but that can be adjuste with flag arguments ().
 - jdwm binaries (`jdwm`, `jdwm-msg`, and `dwmblocks`) from `/usr/local/bin/`
 - All scripts (with the `.sh` extension) present in `/jdwm/dwm/scripts/`, `/jdwm/dwmblocks/scripts/`, and `/jdwm/rofi/scripts/`, from `/usr/local/bin/`
 - Any and all files present in `~/.config/jdwm/`
 - Pathing symlink `/usr/local/share/jdwm`
 - jdwm manual (`/usr/local/share/man/man1/jdwm.1`) and desktop file (`/usr/share/xsessions/jdwm.desktop`)
 - rofi config (`~/.config/rofi/config.rasi`') and all themes (with `.rasi` extension) present in `/jdwm/rofi/themes/` from `~/.config/rofi/themes/`

You can also customize your uninstall with uninstaller flags. To see a list of all flags and their purpose, run:

```bash
./uninstall.sh -h
```
```bash
./uninstall.sh --help
```

Below are some examples of how these can be used and combined:

<details><summary><b>Example: Only uninstall jdwm binaries (`jdwm`, `jdwm-msg`, and `dwmblocks`)</b></summary>

```bash
./install -jb
```
```bash
./install --jdwm-binaries
```
</details>

<details><summary><b>Example: Only uninstall jdwm aliases, manual, and desktop file</b></summary>

```bash
./install -ja -jd -jm
```
```bash
./install --jdwm-aliases --jdwm-desktop-file --jdwm-manual
```
</details>

## Required Dependencies

These are all programs or libraries jdwm relies on (specified in `()`) in some way or another. To not have them would severely reduce the functionality or result in the whole thing being non-functional.

Also, if anyone would like to add more package managers or distros to this list, I would appreciate it, please either reach out on discord @jeffofbread, start a discussion here on github, or create a pull request. 

- A terminal emulator of some kind (chosen in `/jdwm/dwm/resources/jdwm.aliases`, by default it is [kitty](https://sw.kovidgoyal.net/kitty/))
- A desktop notification handler of some kind (I recommend [dunst](https://github.com/dunst-project/dunst))
- [yajl](https://lloyd.github.io/yajl/) (dwm IPC)
- [imlib2](https://docs.enlightenment.org/api/imlib2/html/) (for program icons in the bar)
- [argp](https://www.gnu.org/software/libc/manual/html_node/Argp.html) (for cli arguments in jdwm and jdwm-msg)
- [feh](https://feh.finalrewind.org/) (Background wallpaper. Used in themes shipped in `/jdwm/dwm/themes/`)
- [rofi](https://github.com/davatorium/rofi) (layout menu changer, window switcher, program launcher, etc. Technically not 100% dependent, but designed with it in mind)
- [grep](https://www.gnu.org/software/grep/manual/grep.html), [sed](https://www.gnu.org/software/sed/manual/sed.html), and [cut](https://www.gnu.org/software/coreutils/cut) (various scripts)

<details><summary><b>Arch</b></summary>

```bash
sudo pacman -S yajl imlib2 gcc feh rofi grep sed coreutils
```
or

```bash
yay -S yajl imlib2 gcc feh rofi grep sed coreutils
```

</details>

## Optional Dependencies

These are all optional and easily changeable in their respective config files or scripts, these are just what are used out of the box.

Also, if anyone would like to add more package managers or distros to this list, I would appreciate it, please either reach out on discord @jeffofbread, start a discussion here on github, or create a pull request. 

- A Compositor of some kind (I recommend https://github.com/FT-Labs/picom)
- [jq](https://github.com/jqlang/jq) (For rofi layout menu script)
- [xrandr](https://www.x.org/wiki/Projects/XRandR/) (Monitor resolution, refresh rate, etc)
- [dunst](https://github.com/dunst-project/dunst) (Desktop Notifications)
- [pactl](https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/CLI/#pactl) (Toggle mute on mic/sink binds)
- [playerctl](https://github.com/altdesktop/playerctl) (Media control binds)
- [pamixer](https://github.com/cdemoulins/pamixer) (Volume binds)
- [betterlockscreen](https://github.com/betterlockscreen/betterlockscreen) (For rofi powermenu script)
- [rofi-calc](https://github.com/svenstaro/rofi-calc/tree/master?tab=readme-ov-file) (Calculator bind)
- [Firefox](https://www.mozilla.org/en-US/firefox/new/) (jdwm.aliases, used as the default browser)
- [VSCodium](https://vscodium.com/) (jdwm.aliases, used as the default text editor)
- [Thunar](https://docs.xfce.org/xfce/thunar/start) (jdwm.aliases, used as the default file browser)

<details><summary><b>Arch</b></summary>

(Lacks [betterlockscreen](https://github.com/betterlockscreen/betterlockscreen) and [VSCodium](https://vscodium.com/) because they are AURs)
```bash
sudo pacman -S jq xorg-xrandr dunst libpulse playerctl pamixer rofi-calc firefox thunar
```

or

```bash
yay -S jq xorg-xrandr dunst libpulse playerctl pamixer betterlockscreen rofi-calc firefox vscodium-bin thunar
```

</details>

## Usage

This is not yet a comprehensive list, just a good place to start. All of the keybinds and button binds are found and edited in `/jdwm/dwm/config/binds.h`. 

<details><summary><b>Keybind Quickstart</b></summary><p><div>

These are just the keybinds I find myself using the most often, though "*quick*" might not be the best descriptor here. In the interest of keeping this a little shorter, I won't include them here, but I would also recommend checking out the media keybinds as well. 

Keybind | Action
----------------- | ----------
 <kbd>Win</kbd> + <kbd>Q</kbd> | Kill focused window 
 <kbd>Win</kbd> + <kbd>1</kbd> .. <kbd>9</kbd> | Navigate to `number` tag on the focused monitor
 <kbd>Win</kbd> + <kbd>Shift</kbd> + <kbd>1</kbd> .. <kbd>9</kbd> | Send focused window and view to `number` tag on the focused monitor
 <kbd>Win</kbd> + <kbd>D</kbd> | rofi application launcher
 <kbd>Win</kbd> + <kbd>D</kbd> | rofi power menu
 <kbd>Win</kbd> + <kbd>L</kbd> | rofi layout switcher
 <kbd>Win</kbd> + <kbd>H</kbd> | rofi based theme switcher (switches jdwm's and rofi's theme)
 <kbd>Alt</kbd> + <kbd>Tab</kbd> | rofi window switcher
 <kbd>Win</kbd> + <kbd>Enter</kbd> | Spawn `$TERM` (Found in `jdwm.aliases`, by default [kitty](https://sw.kovidgoyal.net/kitty/))
 <kbd>Win</kbd> + <kbd>W</kbd> | Spawn `$BROWSER` (Found in `jdwm.aliases`, by default [Firefox](https://www.mozilla.org/en-US/firefox/new/))
 <kbd>Win</kbd> + <kbd>C</kbd> | Spawn `$CODE_EDITOR` (Found in `jdwm.aliases`, by default [VSCodium](https://vscodium.com/))
 <kbd>Win</kbd> + <kbd>A</kbd> | Spawn `$FILE_MANAGER` (Found in `jdwm.aliases`, by default [Thunar](https://docs.xfce.org/xfce/thunar/start))
 <kbd>Win</kbd> + <kbd>~</kbd> | Spawn `$SCRATCHPAD` (Found in `jdwm.aliases`, by default [kitty](https://sw.kovidgoyal.net/kitty/))
 <kbd>Win</kbd> + <kbd>Shift</kbd> + <kbd>~</kbd> | Spawn another `$SCRATCHPAD` 
 <kbd>Win</kbd> + <kbd>&leftarrow;</kbd> | Move focus to the next left monitor
 <kbd>Win</kbd> + <kbd>&rightarrow;</kbd> | Move focus to the next right monitor
 <kbd>Win</kbd> + <kbd>Shift</kbd> + <kbd>&leftarrow;</kbd> | Move focused window to next left monitor
 <kbd>Win</kbd> + <kbd>Shift</kbd> + <kbd>&rightarrow;</kbd> | Move focused window to next right monitor
 <kbd>Win</kbd> + <kbd>&uparrow;</kbd> | Move focus up client stack
 <kbd>Win</kbd> + <kbd>&downarrow;</kbd> | Move focus down client stack
 <kbd>Win</kbd> + <kbd>Shift</kbd> + <kbd>&uparrow;</kbd> | Move focused window up a tag
 <kbd>Win</kbd> + <kbd>Shift</kbd> + <kbd>&downarrow;</kbd> | Move focused window down a tag
 <kbd>Win</kbd> + <kbd>F</kbd> | Make the focused window fullscreen, taking up the whole monitor
 <kbd>Win</kbd> + <kbd>Shift</kbd> + <kbd>F</kbd> | Fake Fullscreen, makes the focused window respect layout even when, for example, a YouTube video is fullscreen. 
 <kbd>Win</kbd> + <kbd>Shift</kbd> + <kbd>Q</kbd> | Reload jdwm, same as sending `kill -HUP $(pidof jdwm)`
 <kbd>Win</kbd> + <kbd>Control</kbd> + <kbd>Shift</kbd> + <kbd>Q</kbd> | Quit jdwm, same as sending `kill -TERM $(pidof jdwm)` 

</div></p></details>

<details><summary><b>Media Keybinds</b></summary><p><div>

Keybind | Action
----------------- | ----------
 <kbd>Win</kbd> + <kbd>PageUp</kbd> | Increase volume by 5% using [pamixer](https://github.com/cdemoulins/pamixer)
 <kbd>Win</kbd> + <kbd>PageDown</kbd> | Decrease volume by 5% using [pamixer](https://github.com/cdemoulins/pamixer) 
 <kbd>Win</kbd> + <kbd>ScrollLock</kbd> | Play the next song in queue using [playerctl](https://github.com/altdesktop/playerctl)
 <kbd>Win</kbd> + <kbd>Print</kbd> | Play the previous song in queue using [playerctl](https://github.com/altdesktop/playerctl)
 <kbd>Win</kbd> + <kbd>Home</kbd> | Skip 10 seconds forward using [playerctl](https://github.com/altdesktop/playerctl)
 <kbd>Win</kbd> + <kbd>Home</kbd> | Rewind 10 seconds backwards using [playerctl](https://github.com/altdesktop/playerctl)
 <kbd>Win</kbd> + <kbd>Pause</kbd> | Pause/Play media using [playerctl](https://github.com/altdesktop/playerctl)
 <kbd>Win</kbd> + <kbd>Insert</kbd> | Toggle mute audio output using [pactl](https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/CLI/#pactl)
 <kbd>Win</kbd> + <kbd>Delete</kbd> | Toggle mute microphone using [pactl](https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/CLI/#pactl)

</div></p></details>

<details><summary><b>Aliased Program Keybinds</b></summary><p><div>

Keybind | Action
----------------- | ----------
 <kbd>Win</kbd> + <kbd>Enter</kbd> | Spawn `$TERM` (Found in `jdwm.aliases`, by default [kitty](https://sw.kovidgoyal.net/kitty/))
 <kbd>MMB</kbd> on Window Title | Spawn `$TERM` (Found in `jdwm.aliases`, by default [kitty](https://sw.kovidgoyal.net/kitty/))
 <kbd>Win</kbd> + <kbd>W</kbd> | Spawn `$BROWSER` (Found in `jdwm.aliases`, by default [Firefox](https://www.mozilla.org/en-US/firefox/new/))
 <kbd>Win</kbd> + <kbd>C</kbd> | Spawn `$CODE_EDITOR` (Found in `jdwm.aliases`, by default [VSCodium](https://vscodium.com/))
 <kbd>Win</kbd> + <kbd>A</kbd> | Spawn `$FILE_MANAGER` (Found in `jdwm.aliases`, by default [Thunar](https://docs.xfce.org/xfce/thunar/start))
 <kbd>Control</kbd> + <kbd>Shift</kbd> + <kbd>Q</kbd> | Spawn `$RECOMPILE_TERM` (Found in `jdwm.aliases`, by default [kitty](https://sw.kovidgoyal.net/kitty/))
 <kbd>Win</kbd> + <kbd>~</kbd> | Spawn `$SCRATCHPAD` (Found in `jdwm.aliases`, by default [kitty](https://sw.kovidgoyal.net/kitty/))
 <kbd>Win</kbd> + <kbd>Shift</kbd> + <kbd>~</kbd> | Spawn another `$SCRATCHPAD` 

</div></p></details>

<details><summary><b>Button Binds</b></summary><p><div>

Button + Keybind | Bar Section | Action
---------------- | ----------- | ----------
 <kbd>LMB</kbd> | Layout Symbol | Toggle between most recent layouts
 <kbd>LMB</kbd> | Tag Number | Send focus to that tag
 <kbd>LMB</kbd> + <kbd>Win</kbd> | Tag Number | Send focus and focused window to that tag
 <kbd>LMB</kbd> + <kbd>Win</kbd> | Window | Click and drag floating windows around
 <kbd>LMB</kbd> + <kbd>Win</kbd> + <kbd>Control</kbd> | Window | Click and drag any non-floating window into floating
 <kbd>MMB</kbd> | Window Title | Spawn `$TERM` (Found in `jdwm.aliases`, by default [kitty](https://sw.kovidgoyal.net/kitty/))
 <kbd>MMB</kbd> | Layout Symbol | Spawn rofi based theme switcher (switches jdwm's and rofi's theme)
 <kbd>MMB</kbd> + <kbd>Win</kbd> | Window | Toggle window's floating state
 <kbd>RMB</kbd> | Layout Symbol | Spawn rofi layout switcher
 <kbd>RMB</kbd> | Tag Number | Focus that tag as well as your current tag (view both at the same time)
 <kbd>RMB</kbd> + <kbd>Win</kbd> | Window | Click and drag floating window's edge to resize the window

</div></p></details>

## Patches

All the original .diff files are located in [jdwm patches branch](https://github.com/JeffofBread/jdwm/tree/patches). Needless to say that a lot of tweaks had to be made to many of these patches when implemented to make them all work together, so the .diff files may not represent exactly what is present in jdwm. These changes are to be expected when adding 34 patches on top of each other, and is not a fault of the original authors. Also, many of these patches were pulled from [bakkeby's](https://github.com/bakkeby) incredible [flexipatch](https://github.com/bakkeby/dwm-flexipatch), but I frankly don't remember exactly which, though I have tried my best to provide links below. Also, major thanks to [bakkeby](https://github.com/bakkeby) and [FT-Labs](https://github.com/FT-Labs) for help with a few problems as well as for making their own builds of dwm, which I shamelessly pulled from.


<details><summary><b>Patches integrated in jdwm</b></summary>
<br>

- [alwayscenter](https://dwm.suckless.org/patches/alwayscenter/)
- [barpadding](https://dwm.suckless.org/patches/barpadding/)
- [bartoggle](https://dwm.suckless.org/patches/bartoggle/)
- [centeredwindowname](https://dwm.suckless.org/patches/centeredwindowname/)
- [colorbar](https://dwm.suckless.org/patches/colorbar/)
- [cursorwarp](https://dwm.suckless.org/patches/cursorwarp/)
- [desktopicons](https://github.com/bakkeby/patches/blob/master/dwm/dwm-desktop_icons-6.5.diff)
- [dragmfacts](https://dwm.suckless.org/patches/dragmfact/)
- [ewmhtags](https://dwm.suckless.org/patches/ewmhtags/)
- [floatbordercolor](https://dwm.suckless.org/patches/float_border_color/)
- [floatborderwidth](https://dwm.suckless.org/patches/floatborderwidth/)
- [fullscreencompilation](https://github.com/bakkeby/patches/wiki/fullscreen-compilation)
- [hidevacanttags](https://dwm.suckless.org/patches/hide_vacant_tags/)
- [ignoretransientwindows](https://dwm.suckless.org/patches/ignore_transient_windows/)
- [ipc](https://github.com/mihirlad55/dwm-ipc)
- [layoutscroll](https://dwm.suckless.org/patches/layoutscroll/)
- [noborderflicker](https://dwm.suckless.org/patches/noborderflicker/)
- [pertag](https://dwm.suckless.org/patches/pertag/)
- [preserveonrestart](https://dwm.suckless.org/patches/preserveonrestart/)
- [resizecorners](https://dwm.suckless.org/patches/resizecorners/)
- [restartsig](https://dwm.suckless.org/patches/restartsig/)
- [rotatestack](https://dwm.suckless.org/patches/rotatestack/)
- [scratchpad](https://dwm.suckless.org/patches/scratchpad/)
- [shiftools](https://dwm.suckless.org/patches/shift-tools/)
- [statuspadding](https://dwm.suckless.org/patches/statuspadding/)
- [steam](https://dwm.suckless.org/patches/steam/)
- [sticky](https://dwm.suckless.org/patches/sticky/)
- [stickyindicator](https://dwm.suckless.org/patches/stickyindicator/)
- [switchallmonitortags](https://dwm.suckless.org/patches/switch_all_monitor_tags/)
- [systray](https://dwm.suckless.org/patches/systray/)
- [underlinetags](https://dwm.suckless.org/patches/underlinetags/)
- [unmanaged](https://github.com/bakkeby/patches/blob/master/dwm/dwm-unmanaged-6.5.diff)
- [vanitygaps](https://dwm.suckless.org/patches/vanitygaps/)
- [winicon](https://dwm.suckless.org/patches/winicon/)

</details>

## Known Bugs

- Steam (specifically toast notifications) causing tiling issues.
- There might be a conflict between dwm-ipc and pertag, where jdwm-msg does not always dump correct values. I will look into it in the future. 

## Future

I still have many plans for changes and features, but currently don't have that much time to put towards this project, so don't expect too many updates, at least not rapid ones. If you would like to suggest ideas, features, or contribute, please either reach out on discord @jeffofbread, start a discussion here on github, or create a pull request. 

