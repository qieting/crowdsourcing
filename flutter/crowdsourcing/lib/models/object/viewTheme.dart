

class ViewTheme {

  static const FontSize = 'fontsize';
  static const ThemeColorIndex = 'themecolorindex';
  static const DarkMode ='drakmode';
  static const FontValueList = ['system', 'kuaile'];

  int fontsize;
  int themeColorIndex;
  bool drakMode;
  int  fontindex;

  ViewTheme(){
    drakMode=false;
    themeColorIndex=6;
    fontindex=0;
    fontsize=1;
  }

  static ViewTheme fromJsonMap(Map<String, dynamic> map) {
    if (map == null ) return null;
    ViewTheme user  = ViewTheme();
    user.fontsize = map[FontSize];
    user.themeColorIndex = map[ThemeColorIndex];
    user.drakMode = map[DarkMode];
    user.fontindex = map[FontValueList];
    return user;
  }

  Map toJson() => {FontSize: fontsize,ThemeColorIndex:themeColorIndex, DarkMode:drakMode,FontValueList:fontindex};

}