part of '../shared.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  CustomAppBar({
    // ignore: invalid_required_named_param
    @required this.title = "Title",
    // ignore: invalid_required_named_param
    @required this.subtitle = "subtitle",
    @required this.onBackButtonPressed,
    this.onTrailingButtonPressed,
    this.height,
    this.color,
    this.trailingColor = Colors.white,
    this.textColor,
    this.trailingIcon,
  });
  Size size;
  final String title;
  final String subtitle;
  final double height;
  final Color color;
  final Color trailingColor;
  final Color textColor;
  final Function onBackButtonPressed;
  final Function onTrailingButtonPressed;
  final dynamic trailingIcon;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: defaultMargin * 0.5),
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      width: size.width,
      height: height != null ? height : 100,
      color: color != null ? color : Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size.width * 0.7,
            child: Row(
              children: [
                onBackButtonPressed != null
                    ? InkWell(
                        onTap: () {
                          if (onBackButtonPressed != null)
                            PrintDebug.printDialog(
                                id: productQCScreen, msg: 'Testtt');
                          onBackButtonPressed();
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          margin: EdgeInsets.only(right: 26),
                          decoration: BoxDecoration(),
                          child: Icon(Icons.arrow_back_ios_outlined,
                              color:
                                  textColor != null ? textColor : Colors.black),
                        ),
                      )
                    : SizedBox(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: textColor != null ? textColor : Colors.black),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                          color: textColor != null
                              ? textColor
                              : "8D92A3".toColor(),
                          fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ],
            ),
          ),
          onTrailingButtonPressed != null
              ? InkWell(
                  onTap: () {
                    if (onTrailingButtonPressed != null)
                      PrintDebug.printDialog(
                          id: productQCScreen, msg: 'Trailing pressed');
                    onTrailingButtonPressed();
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    child: Icon(
                      trailingIcon,
                      color: trailingColor,
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
