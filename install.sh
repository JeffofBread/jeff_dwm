#!/bin/bash

# Check script is run as non root to get correct paths
if ! [ $(id -u) != 0 ]; then
    echo "The script need to be run as non-root to start."
    exit 1
fi

########################################################

PARENT_DIR=$(pwd)
BIN_INSTALL_DIR="/usr/local/bin"
SHARE_DIR="/usr/local/share"
USERS_DIR=$HOME

########################################################

ROFI_DIR="$PARENT_DIR/rofi"
ROFI_SCRIPTS_DIR="$ROFI_DIR/scripts"
ROFI_THEMES_DIR="$ROFI_DIR/themes"
ROFI_CONFIG_INSTALL_DIR="$USERS_DIR/.config/rofi"
ROFI_THEMES_INSTALL_DIR="$ROFI_CONFIG_INSTALL_DIR/themes"

########################################################

JEFF_DWM_VERSION=$(grep Makefile -e "VERSION = " | cut -b 11-)

JEFF_DWM_DIR="$PARENT_DIR/dwm"
JEFF_DWM_CONFIG_DIR="$JEFF_DWM_DIR/config"
JEFF_DWM_USER_CONFIG_DIR="$USERS_DIR/.config/jeff_dwm"
JEFF_DWM_WALLPAPER_DIR="$JEFF_DWM_USER_CONFIG_DIR/wallpapers"
JEFF_DWM_THEMES_DIR="$JEFF_DWM_DIR/themes"
JEFF_DWM_SCRIPTS_DIR="$JEFF_DWM_DIR/scripts"
JEFF_DWM_RESOURCES_DIR="$JEFF_DWM_DIR/resources"

JEFF_DWM_SETUPFILE="$JEFF_DWM_SCRIPTS_DIR/jeff_dwm_setup.sh"
JEFF_DWM_EXAMPLE_SETUPFILE="$JEFF_DWM_SCRIPTS_DIR/jeff_dwm_setup.example"

########################################################

DWM_BLOCKS_DIR="$PARENT_DIR/dwmblocks"
DWM_BLOCKS_CONFIG_DIR="$DWM_BLOCKS_DIR/config"
DWM_BLOCKS_SCRIPTS_DIR="$DWM_BLOCKS_DIR/scripts"

########################################################

DWM_MAN_INSTALL_DIR=""
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    DWM_MAN_INSTALL_DIR="$SHARE_DIR/man"
elif [[ "$OSTYPE" == "openbsd"* ]]; then
    DWM_MAN_INSTALL_DIR="/usr/local/man"
fi

########################################################

check_and_link(){
    if [ ! -f "$1.h" ]; then
        response=y
        read -p "$1.h does not exist. Would you like to copy $1.def.h? [Y/n] " response
        if [[ "$response" =~ ^([nN][oO]|[nN])$ ]] then
            echo -e "No copy made, exiting script..."
            exit 0
        else
            if [ ! -f "$1.def.h" ]; then
                echo -e "Error: $1.def.h does not exist, nothing to copy"
                exit 1
            else
                echo -e "Copying $1.def.h to $1.h"
                cp $1.def.h $1.h
            fi
        fi
    fi

    jeff_dwm_check_config_dir

    if [ -L "$JEFF_DWM_USER_CONFIG_DIR/$2.h" ]; then
        echo "Symbolic link to $1.h in $JEFF_DWM_USER_CONFIG_DIR/ already exists, skipping creation"
    else
        echo "Symbolic link to $1.h being created in $JEFF_DWM_USER_CONFIG_DIR/"
        ln -s $1.h $JEFF_DWM_USER_CONFIG_DIR/$2.h &>/dev/null
    fi
}

jeff_dwm_aliases_install(){
    echo -e "\n|--------- jeff_dwm aliases ----------|\n"

    jeff_dwm_check_config_dir

    if [ ! -f "$JEFF_DWM_USER_CONFIG_DIR/jeff_dwm.aliases" ]; then
        if [ ! -f "$JEFF_DWM_RESOURCES_DIR/jeff_dwm.aliases" ]; then
            echo -e "Error: $JEFF_DWM_RESOURCES_DIR/jeff_dwm.aliases does not exist, nothing to copy"
            exit 1
        else 
            echo -e "$JEFF_DWM_RESOURCES_DIR/jeff_dwm.aliases to $JEFF_DWM_USER_CONFIG_DIR/jeff_dwm.aliases"
            cp $JEFF_DWM_RESOURCES_DIR/jeff_dwm.aliases $JEFF_DWM_USER_CONFIG_DIR/jeff_dwm.aliases
        fi
    else 
        response=n
        read -p "Would you like to overwrite current jeff_dwm.aliases file? [y/N] " response
        if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]] then
            echo -e "$JEFF_DWM_RESOURCES_DIR/jeff_dwm.aliases to $JEFF_DWM_USER_CONFIG_DIR/jeff_dwm.aliases"
            cp $JEFF_DWM_RESOURCES_DIR/jeff_dwm.aliases $JEFF_DWM_USER_CONFIG_DIR/jeff_dwm.aliases
        else
            echo -e "Original jeff_dwm.aliases not overwritten"
        fi
    fi
    if grep -q jeff_dwm.aliases "$USERS_DIR/.bashrc"; then
        echo "jeff_dwm.aliases already present in .bashrc, skipping addition"
    else
        echo "Adding link to $JEFF_DWM_USER_CONFIG_DIR/jeff_dwm.aliases in .bashrc"
        echo -e "\n\n#jeff_dwm aliases\n. $JEFF_DWM_USER_CONFIG_DIR/jeff_dwm.aliases" >> $USERS_DIR/.bashrc
    fi
    echo ""
}

jeff_dwm_binaries_install(){
    echo -e "\n|--------- jeff_dwm binaries ---------|\n"
    sudo make install
    echo ""
}

jeff_dwm_check_config_dir(){
    if [ -d "$JEFF_DWM_USER_CONFIG_DIR" ]; then
        echo "$JEFF_DWM_USER_CONFIG_DIR already exists, skipping creation"  
    else
        echo "Creating jeff_dwm config directory in $JEFF_DWM_USER_CONFIG_DIR"
        mkdir -p $JEFF_DWM_USER_CONFIG_DIR
    fi
}

jeff_dwm_configs_link(){
    echo -e "\n|------- jeff_dwm config links -------|\n"

    jeff_dwm_check_config_dir

    check_and_link "$JEFF_DWM_CONFIG_DIR/autorun" "autorun"
    check_and_link "$JEFF_DWM_CONFIG_DIR/binds" "binds"
    check_and_link "$JEFF_DWM_CONFIG_DIR/config" "config"
    check_and_link "$JEFF_DWM_CONFIG_DIR/keydefs" "keydefs"
    check_and_link "$DWM_BLOCKS_CONFIG_DIR/blocks" "blocks"

    if [ -L "$JEFF_DWM_CONFIG_DIR/jeffdwmconfigdir" ] && [ -d "$JEFF_DWM_CONFIG_DIR/jeffdwmconfigdir" ]; then
        echo "Symbolic link to $JEFF_DWM_USER_CONFIG_DIR in $JEFF_DWM_CONFIG_DIR already exists, skipping creation"  
    else
        echo "Creating symbolic link to to $JEFF_DWM_USER_CONFIG_DIR in $JEFF_DWM_CONFIG_DIR called /jeffdwmconfigdir"
        ln -s $JEFF_DWM_USER_CONFIG_DIR $JEFF_DWM_CONFIG_DIR/jeffdwmconfigdir
    fi
    
    echo ""
}

jeff_dwm_desktop_file_install(){
    echo -e "\n|--------- jeff_dwm .desktop ---------|\n"
    echo -e "jeff_dwm.desktop being installed to /usr/share/xsessions/"
    sudo cp -f $JEFF_DWM_RESOURCES_DIR/jeff_dwm.desktop /usr/share/xsessions/jeff_dwm.desktop
    sudo /bin/sh -c "(echo "$JEFF_DWM_VERSION"; echo "Icon=$JEFF_DWM_RESOURCES_DIR/dwm.png") >> /usr/share/xsessions/jeff_dwm.desktop"
    echo ""
}

jeff_dwm_man_page_install(){
    echo -e "\n|------------ jeff_dwm man -----------|\n"
    echo -e "jeff_dwm manual being installed to $DWM_MAN_INSTALL_DIR/man1 from $JEFF_DWM_RESOURCES_DIR/jeff_dwm.1"
    mkdir -p $DWM_MAN_INSTALL_DIR/man1
    sudo /bin/sh -c "sed "s/VERSION/$JEFF_DWM_VERSION/g" < $JEFF_DWM_RESOURCES_DIR/jeff_dwm.1 > $DWM_MAN_INSTALL_DIR/man1/jeff_dwm.1 && chmod 644 $DWM_MAN_INSTALL_DIR/man1/jeff_dwm.1"
    echo ""
}

jeff_dwm_scripts_install(){
    echo -e "\n|---------- jeff_dwm scripts ---------|\n"
    if [ -L "$SHARE_DIR/jeff_dwm" ] && [ -d "$SHARE_DIR/jeff_dwm" ]; then
        echo "Symbolic link to $PARENT_DIR in $SHARE_DIR already exists, skipping creation"  
    else
        echo "Creating symbolic link to $PARENT_DIR in $SHARE_DIR called /jeff_dwm"
        sudo /bin/sh -c "ln -s $PARENT_DIR $SHARE_DIR/jeff_dwm  &>/dev/null"
    fi
    if [ ! -f $JEFF_DWM_SETUPFILE ]; then
        if [ ! -f $JEFF_DWM_EXAMPLE_SETUPFILE ]; then
            echo -e "Error: $JEFF_DWM_EXAMPLE_SETUPFILE does not exist, no default config to copy.\n"
        else
            echo -e "\nCopying default setup config."
            cp $JEFF_DWM_EXAMPLE_SETUPFILE $JEFF_DWM_SETUPFILE
        fi
    fi
    echo -e "jeff_dwm scripts are being installed to $BIN_INSTALL_DIR from $JEFF_DWM_SCRIPTS_DIR"
    echo -e "jeff_dwm scripts being installed:\n"
    cd $JEFF_DWM_SCRIPTS_DIR 
    sudo chmod -R 755 ./
    sudo cp -f *.sh $BIN_INSTALL_DIR
    ls | grep -E '\.sh$' | sed -e 's/^/     #) /'
    echo ""
}

jeff_dwm_wallpapers_install(){
    echo -e "\n|-------- jeff_dwm wallpapers --------|\n"

    if [ -d "$JEFF_DWM_WALLPAPER_DIR" ]; then
        response=n
        read -p "Would you like to check for wallpaper updates (git pull)? [y/N] " response
        if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]] then
            git pull
        else
            echo -e "Skipping checking for update"
        fi 
    else
        echo "Cloning jeff_dwm_wallpapers repo into $JEFF_DWM_WALLPAPER_DIR"
        git clone https://github.com/JeffofBread/jeff_dwm.git -b wallpapers $JEFF_DWM_WALLPAPER_DIR
    fi

    if [ -L "$JEFF_DWM_THEMES_DIR/wallpapers" ] && [ -d "$JEFF_DWM_THEMES_DIR/wallpapers" ]; then
        echo "Symbolic link to $JEFF_DWM_WALLPAPER_DIR in $JEFF_DWM_THEMES_DIR already exists, skipping creation"  
    else
        echo "Creating symbolic link to to $JEFF_DWM_WALLPAPER_DIR in $JEFF_DWM_THEMES_DIR called /wallpapers"
        ln -s $JEFF_DWM_WALLPAPER_DIR $JEFF_DWM_THEMES_DIR/wallpapers
    fi
}

dwm_blocks_scripts_install(){
    echo -e "\n|--------- dwmblocks scripts ---------|\n"
    echo -e "\ndwmblocks scripts are being installed to $BIN_INSTALL_DIR from $DWM_BLOCKS_SCRIPTS_DIR"
    echo -e "dwmblocks scripts being installed:\n"
    cd $DWM_BLOCKS_SCRIPTS_DIR 
    sudo chmod -R 755 ./
    sudo cp -f *.sh $BIN_INSTALL_DIR
    ls | grep -E '\.sh$' | sed -e 's/^/     #) /'
    echo ""
}

rofi_config_install(){
    echo -e "\n|-------- Rofi config install --------|\n"
    echo -e "Rofi config being installed to $ROFI_CONFIG_INSTALL_DIR from $ROFI_DIR/config.rasi" 
    mkdir -p $ROFI_CONFIG_INSTALL_DIR 
    if [ -f "$ROFI_CONFIG_INSTALL_DIR/config.rasi" ]; then
        response=y
        read -p "Would you like to backup current config.rasi file? [Y/n] " response
        if [[ "$response" =~ ^([nN][oO]|[nN])$ ]] then
            echo -e "No backup being made"
        else
            # minute-hour-day-month-year, overkill but idc
            date="$(date '+%M-%H-%d-%m-%Y')"
            echo -e "Existing rofi config being backed up as config.rasi.$date.bak"
            cp $ROFI_CONFIG_INSTALL_DIR/config.rasi $ROFI_CONFIG_INSTALL_DIR/config.rasi.$date.bak
        fi
    fi
    cp -f $ROFI_DIR/config.rasi $ROFI_CONFIG_INSTALL_DIR
    echo ""
}

rofi_scripts_install(){
    echo -e "\n|-------- Rofi scripts install -------|\n"
    echo -e "Rofi scripts are being installed to $BIN_INSTALL_DIR from $ROFI_SCRIPTS_DIR:"
    echo -e "Rofi scripts being installed:\n"
    cd $ROFI_SCRIPTS_DIR 
    sudo chmod -R 755 ./
    sudo cp -f *.sh $BIN_INSTALL_DIR
    ls | grep -E '\.sh$' | sed -e 's/^/     #) /'
    echo ""
}

rofi_theme_install(){
    echo -e "\n|-------- Rofi theme install ---------|\n"
    mkdir -p $ROFI_THEMES_INSTALL_DIR 
    cd $ROFI_THEMES_DIR && cp -f *.rasi $ROFI_THEMES_INSTALL_DIR 
    echo -e "\nRofi themes are being installed to $ROFI_THEMES_INSTALL_DIR from $ROFI_THEMES_DIR.\nThemes being installed:\n"
    ls | grep -E '\.rasi$' | sed -e 's/^/     #) /'
    echo ""

    # I know the below solution is shit, im just lazy and this works
    if [ -L "$ROFI_DIR/roficonfigdir" ] && [ -d "$ROFI_DIR/roficonfigdir" ]; then
        echo "Symbolic link to $ROFI_CONFIG_INSTALL_DIR in $ROFI_DIR already exists, skipping creation"  
    else
        echo "Creating symbolic link to to $ROFI_CONFIG_INSTALL_DIR in $ROFI_DIR called /roficonfigdir"
        ln -s $ROFI_CONFIG_INSTALL_DIR $ROFI_DIR/roficonfigdir
    fi
    echo ""
}

print_help(){
    print_usage
    echo "This install script is a part of jeff_dwm to assist in installing it"
    echo "along with any scripts, configs, or other necessary files or extras."
    echo "If you need help installing, want to report an issue, make a suggestion,"
    echo "or simply to take another look at the, codebase, head to"
    echo "https://github.com/JeffofBread/jeff_dwm. By default (no flags), all"
    echo "installs will be run."
    echo ""
    echo "Flags (can use one or more, no values necessary):"
    echo ""
    echo "   -h,  --help                        Prints this help and usage message"
    echo ""
    echo "   -u,  --usage                       Prints jeff_dwm's usage help message"
    echo ""
    echo "   -v,  --version                     Prints jeff_dwm's version, same as"
    echo "                                      'jeff_dwm -v'"
    echo ""
    echo "   -ja, --jeff-dwm-aliases            Installs jeff_dwm alias file to"
    echo "                                      ~/.config/jeff_dwm/"
    echo ""
    echo "   -jb, --jeff-dwm-binaries           Installs all jeff_dwm related"
    echo "                                      binaries to /usr/local/bin/ using"
    echo "                                      'sudo make install'"
    echo ""
    echo "   -jc, --jeff-dwm-config-link        Installs symlinks linking config"
    echo "                                      header files in /jeff_dwm/dwm/config/"
    echo "                                      to ~/.config/jeff_dwm/. Not useful to"
    echo "                                      jeff_dwm, just for the user"
    echo ""
    echo "   -jd, --jeff-desktop-file           Installs jeff_dwm's desktop file to"
    echo "                                      /usr/share/xsessions/"
    echo ""
    echo "   -jm, --jeff-dwm-manual             Installs jeff_dwn's-$JEFF_DWM_VERSION manual file"
    echo "                                      to $DWM_MAN_INSTALL_DIR/man1/"
    echo ""
    echo "   -js, --jeff-dwm-scripts            Installs jeff_dwm's script files,"
    echo "                                      meaning any .sh files found in"
    echo "                                      /jeff_dwm/dwm/scripts/, to"
    echo "                                      /usr/local/bin/"
    echo ""
    echo "   -jw, --jeff-dwm-wallpapers         Clones jeff_dwm's wallpapers repo to"
    echo "                                      ~/.config/jeff_dwm/wallpapers and "
    echo "                                      symlinks to it in /jeff_dwm/dwm/themes/"
    echo ""
    echo "   -bs, --dwmblocks-scripts           Installs jeff_dwm's dwmblocks"
    echo "                                      script files, meaning any .sh files"
    echo "                                      found in/jeff_dwm/dwmblocks/scripts/,"
    echo "                                      to /usr/local/bin/"
    echo ""
    echo "   -rc, --rofi-config                 Installs jeff_dwm's rofi config file"
    echo "                                      (/jeff_dwm/rofi/config.rasi) to"
    echo "                                      ~/.config/rofi/config.rasi"
    echo ""
    echo "   -rs, --rofi-scripts                Installs jeff_dwm's rofi scripts,"
    echo "                                      meaning any .sh files found in"
    echo "                                      /jeff_dwm/rofi/scripts/, to"
    echo "                                      /usr/local/bin/"
    echo ""
    echo "   -rt, --rofi-themes                 Installs jeff_dwm's rofi themes,"
    echo "                                      meaning any .rasi files found in"
    echo "                                      both /jeff_dwm/rofi/themes/, to"
    echo "                                      ~/.config/rofi/themes/"
    echo ""
}

print_usage(){
    echo ""
    echo "Usage: install.sh [-h] [--help] [-u] [--usage] [-v] [--version]"
    echo "       [-ja] [--jeff-dwm-aliases] [-jb] [--jeff-dwm-binaries]"
    echo "       [-jc] [--jeff-dwm-config-link ] [-jd] [--jeff-desktop-file]"
    echo "       [-jm] [--jeff-dwm-manual] [-js] [--jeff-dwm-scripts]"
    echo "       [-jw] [--jeff-dwm-wallpapers] [-bs] [--dwmblocks-scripts]"
    echo "       [-rc] [--rofi-config] [-rs] [--rofi-scripts] [-rt]"
    echo "       [--rofi-themes]"
    echo ""  
}

########################################################

DEFAULT_INSTALL=1

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
    case $1 in
        -ja|--jeff-dwm-aliases)  # Only installs the custom alias file
            jeff_dwm_aliases_install
            DEFAULT_INSTALL=0
            shift
            ;;
        -jb|--jeff-dwm-binaries)  # Only install binaries, aka just runs make install
            jeff_dwm_binaries_install
            DEFAULT_INSTALL=0
            shift
            ;;
        -jc|--jeff-dwm-config-link)  # Only installs config symlinks
            jeff_dwm_configs_link
            DEFAULT_INSTALL=0
            shift
            ;;
        -jd|--jeff-dwm-desktop-file)  # Only installs the .desktop file for jeff_dwm
            jeff_dwm_desktop_file_install
            DEFAULT_INSTALL=0
            shift
            ;;
        -jm|--jeff-dwm-manual)  # Only installs jeff_dwm manual
            jeff_dwm_man_page_install
            DEFAULT_INSTALL=0
            shift
            ;;
        -js|--jeff-dwm-scripts)  # Only installs dwm scripts
            jeff_dwm_scripts_install
            DEFAULT_INSTALL=0
            shift
            ;;
        -jw|--jeff-dwm-wallpapers)  # Only installs wallpapers and its symlink
            jeff_dwm_wallpapers_install
            DEFAULT_INSTALL=0
            shift
            ;;
        -bs|--dwmblocks-scripts)  # Only installs dwmblocks scripts
            dwm_blocks_scripts_install
            DEFAULT_INSTALL=0
            shift
            ;;
        -rc|--rofi-config)  # Only installs rofi config
            rofi_config_install
            DEFAULT_INSTALL=0
            shift
            ;;
        -rs|--rofi-scripts)  # Only installs rofi scripts
            rofi_scripts_install
            DEFAULT_INSTALL=0
            shift
            ;;
        -rt|--rofi-themes)  # Only installs rofi themes
            rofi_theme_install
            DEFAULT_INSTALL=0
            shift
            ;;
        -v|--version)  # Prints jeff_dwm's version
            echo "jeff_dwm version: $JEFF_DWM_VERSION"
            exit 0
            ;;
        -h|--help)  # Help print message
            print_help
            exit 0
            ;;
        -u|--usage)  # Usage print message
            print_usage
            exit 0
            ;;
        -*|--*)
            echo "Unknown flag $1"
            exit 1
            ;;
        *)
            echo "Unknown option $1"
            exit 1
            ;;
    esac
done

if [[ $DEFAULT_INSTALL -eq 1 ]]; then
    jeff_dwm_aliases_install
    jeff_dwm_binaries_install
    jeff_dwm_desktop_file_install
    jeff_dwm_configs_link
    jeff_dwm_man_page_install
    jeff_dwm_scripts_install
    jeff_dwm_wallpapers_install
    dwm_blocks_scripts_install
    rofi_config_install
    rofi_scripts_install
    rofi_theme_install
fi

echo ""