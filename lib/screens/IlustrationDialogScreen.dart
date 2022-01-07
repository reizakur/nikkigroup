part of 'screens.dart';

// ignore: must_be_immutable
class IlustrationDialog extends StatelessWidget {
  final String asset;
  final String title;
  final String subtitle;
  final String sub2title;
  final String buttonTitle;
  final Function onTap;
  final Color colorButton;
  final Widget customWidget;

  IlustrationDialog(
      {this.asset,
      @required this.title,
      this.subtitle,
      this.sub2title,
      this.customWidget,
      this.buttonTitle,
      this.colorButton = Colors.orange,
      this.onTap});

  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              asset != null
                  ? Container(
                      height: 300,
                      width: 300,
                      margin: EdgeInsets.only(bottom: defaultMargin),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain, image: AssetImage(asset))),
                    )
                  : Container(
                      margin: EdgeInsets.only(bottom: defaultMargin),
                      child: customWidget,
                    ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: blackFontStyle,
              ),
              subtitle != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: defaultMargin,
                          right: defaultMargin,
                          top: defaultMargin * 0.5),
                      child: Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: blackFontStyle2,
                      ),
                    )
                  : SizedBox(),
              sub2title != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: defaultMargin,
                          right: defaultMargin,
                          top: defaultMargin),
                      child: Text(
                        sub2title,
                        textAlign: TextAlign.center,
                        style: greyFontStyle,
                      ),
                    )
                  : SizedBox(),
              buttonTitle != null
                  ? Container(
                      margin: EdgeInsets.only(top: defaultMargin),
                      height: 50,
                      width: 80,
                      child: ElevatedButton(
                        onPressed: () {
                          if (onTap != null) onTap();
                        },
                        child: Text(
                          buttonTitle,
                          style: blackFontStyle2.copyWith(color: Colors.white),
                        ),
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            backgroundColor:
                                MaterialStateProperty.all(colorButton)),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
