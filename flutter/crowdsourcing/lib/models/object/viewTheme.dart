class ViewTheme {
  static const FontSize = 'fontsize';
  static const ThemeColorIndex = 'themecolorindex';
  static const DarkMode = 'drakmode';
  static const FontValueList = ['system', 'kuaile'];
  static const DARKMODELFOLLOW = "follow";

  int fontsize;
  int themeColorIndex;
  bool drakMode;
  int fontindex;
  bool drakModelFollow;

  ViewTheme() {
    drakMode = false;
    themeColorIndex = 6;
    fontindex = 0;
    fontsize = 1;
    drakModelFollow = true;
  }

  static ViewTheme fromJsonMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ViewTheme user = ViewTheme();
    user.fontsize = map[FontSize];
    user.themeColorIndex = map[ThemeColorIndex];
    user.drakMode = map[DarkMode];
    user.fontindex = map[FontValueList[0]];
    user.drakModelFollow = map[DARKMODELFOLLOW] ?? true;
    return user;
  }

  Map<String, dynamic> toJson() => {
        FontSize: fontsize,
        ThemeColorIndex: themeColorIndex,
        DarkMode: drakMode,
        FontValueList[0]: fontindex,
        DARKMODELFOLLOW: drakModelFollow
      };
}
