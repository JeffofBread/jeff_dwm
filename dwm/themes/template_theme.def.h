// Template theme for you to create your own theme
static const char color1[] = "COLOR1 HEXCODE";
static const char color2[] = "COLOR2 HEXCODE";
static const char color3[] = "COLOR3 HEXCODE";
static const char color4[] = "COLOR4 HEXCODE";
static const char color5[] = "COLOR5 HEXCODE";

static const char *colors[][4] = {

	// Clients       foreground     background      border      float
	[SchemeNorm] = { color3,        color1,         color2,     color2 },   // Generic scheme for unfocused clients
	[SchemeSel]  = { color4,        color5,         color2,     color5 },   // Generic scheme for focused clients

	// Bar                  text    background
	[SchemeStatus]  	= { color3, color1 }, // Statusbar right
	[SchemeTagsSel]  	= { color4, color5 }, // Tagbar left selected
	[SchemeTagsNorm]  	= { color3, color1 }, // Tagbar left unselected
	[SchemeInfoSel]  	= { color4, color5 }, // infobar middle selected
	[SchemeInfoNorm]  	= { color3, color1 }, // infobar middle unselected
};

// Wallpaper command executed by execvp() on any run or restart
char *wallpapercmd[] = { "CUSTOM", "WALLPAPER", "CMD", "HERE", NULL };

// Name of the rofi theme file (without path, path defined in jeff_dwm.c, should be generic)
#define ROFITHEMEFILE CUSTOM_ROFI_THEME_FILE_HERE.rasi