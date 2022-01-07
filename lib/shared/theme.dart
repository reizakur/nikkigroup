part of 'shared.dart';

//Color greyColor = "8D82A3".toColor();
Color greyColor = "9fa8b5".toColor();
Color blueBackground = "e8f9ff".toColor();
Color blueGeneralUse = "4c8ed4".toColor();
Color mainColor = "FFC700".toColor();
Color orangeFaded = "FFECDA".toColor();
Color greyBackground = "F0F0F0".toColor();
Widget loadingIndicator = SpinKitFadingCircle(
  size: 45,
  color: mainColor,
);
Widget loadingIndicator2 = SpinKitWave(
  size: 15,
  color: mainColor,
);
TextStyle greyFontStyle = GoogleFonts.poppins().copyWith(color: greyColor);
TextStyle blackFontStyle = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500);
TextStyle blackFontStyle2 = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontSize: 11, fontWeight: FontWeight.w500);
TextStyle blackFontStyle3 = GoogleFonts.poppins().copyWith(color: Colors.black);

const double defaultMargin = 24;
