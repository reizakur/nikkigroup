part of '../shared.dart';

// ignore: must_be_immutable
class IconSquare extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  dynamic iconColor;
  final String badgeContent;

  // ignore: invalid_required_named_param
  IconSquare(
      // ignore: invalid_required_named_param
      {@required this.title = 'No title',
      // ignore: invalid_required_named_param
      @required this.icon = Icons.warning,
      @required this.onTap,
      this.iconColor,
      this.badgeContent = 'No Data'}) {
    if (iconColor == null) iconColor = blueGeneralUse;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Container(
        height: 120,
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Badge(
              badgeContent: Text(badgeContent,
                  style: blackFontStyle.copyWith(color: Colors.white)),
              showBadge: badgeContent != 'No Data' ? true : false,
              badgeColor: Colors.red,
              child: Container(
                height: 60,
                width: 60,
                margin: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            Container(
              height: 40,
              width: 90,
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: blackFontStyle3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
