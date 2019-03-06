class ScreenRatio {
  static double heightRatio;
  static double widthRatio;
  static double screenheight;
  static double screenwidth;

  static setScreenRatio(
      {double currentScreenHeight, double currentScreenWidth}) {
    screenheight = currentScreenHeight;
    screenwidth = currentScreenWidth;
    heightRatio = currentScreenHeight / 812.0;
    widthRatio = currentScreenWidth / 375.0;
  }
}
