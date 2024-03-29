# Jeff's dwm build

A build of dwm for myself and anyone who wishes to use it too. If you find any issues or would like to make a recommendation, feel free. This is a major work in progress and will be changing often and will be receiving major changes in the near future. Any recommendations or critique is appreciated.
## Installation for new users

```bash
git clone https://github.com/JeffofBread/jeff_dwm.git
cd jeff_dwm
./install.sh
```
After your first install, you can use `Ctrl + Shift + Q` to open the recompile script in kitty. To reload jeff_dwm press `Super + Shift + Q`. To exit dwm press `Super + Ctrl + Shift + Q`.

## Dependencies

- yajl
- imlib2
- rofi
- kitty (Heavily recommended and built on, but can be changed in source if you want to spend the time)

## Recommended

- picom
- feh

## Patches

All the original .diff files are located in /dwmpatches. Needless to say that a lot of tweaks had to be made to many of these patches when implemented to make them all work together. Not unexpected when adding almost 40 patches together. Also, many of these patches were pulled from [bakkeby's](https://github.com/bakkeby) incredible [flexipatch](https://github.com/bakkeby/dwm-flexipatch), but I frankly don't remember which. Also major thanks to [FT-Labs](https://github.com/FT-Labs) for helping me learn so much about dwm and x11 directly and indirectly through his [pdwm](https://github.com/FT-Labs/pdwm).

- alternativetags
- alwayscenter
- barpadding
- bartoggle
- centeredwindowname
- colorbar
- coolautostart
- cursorwarp
- decorhints
- dragmfacts
- dynamicswallow
- ewmhtags
- floatbordercolor
- floatborderwidth
- focusonnetactive
- focusurgent
- fullscreencompilation
- hidevacanttags
- ignoretransientwindows
- ipc
- layoutscroll
- noborderflicker
- pertag
- placemouse (slightly buggy with current implementation, is a TODO)
- preserveonrestart
- resizecorners
- restartsig
- rotatestack
- rulerefresher
- scratchpad
- shiftools
- statuspadding
- steam
- sticky
- stickyindicator
- switchallmonitortags
- systray
- underlinetags
- vanitygaps
- winicon
