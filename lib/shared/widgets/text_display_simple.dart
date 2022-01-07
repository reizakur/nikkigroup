part of '../shared.dart';

class SimpleTextDisplay extends StatelessWidget {
  final String leftText;
  final String rightText;

  SimpleTextDisplay({@required this.leftText, @required this.rightText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      //width: size.width,
      //color: Colors.yellow,
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leftText, style: blackFontStyle2.copyWith(color: greyColor)),
          Text(rightText, style: blackFontStyle2.copyWith(color: greyColor)),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class SimpleTextDisplayWtIcon extends StatelessWidget {
  final String leftText;
  final String rightText;
  Color rightColor;
  final Widget leadingIcon;

  SimpleTextDisplayWtIcon(
      {@required this.leftText,
      @required this.rightText,
      @required this.leadingIcon,
      this.rightColor}) {
    if (rightColor == null) rightColor = greyColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      //width: size.width,
      //color: Colors.yellow,
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      margin: EdgeInsets.symmetric(vertical: defaultMargin * 0.25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  leadingIcon,
                  SizedBox(
                    width: 5,
                  ),
                  Text(leftText,
                      style: blackFontStyle2.copyWith(color: greyColor)),
                ],
              )),
          Text(rightText, style: blackFontStyle2.copyWith(color: rightColor)),
        ],
      ),
    );
  }
}
