part of '../shared.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final Widget trailing;
  final String title;
  final String subtitle;
  final Function onTap;
  final Color backgroundColor;
  final Color leadingColor;
  final bool disableTrailing;

  CustomListTile(
      {@required this.icon,
      @required this.title,
      @required this.subtitle,
      @required this.onTap,
      this.trailing,
      this.backgroundColor,
      this.leadingColor,
      this.disableTrailing = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: backgroundColor != null ? backgroundColor : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 2,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.only(
            left: defaultMargin,
            right: defaultMargin,
            bottom: defaultMargin * 0.5),
        child: ListTile(
          leading: Icon(
            icon,
            color: leadingColor != null ? leadingColor : greyColor,
            size: 35,
          ),
          title: Text(
            title,
            style: blackFontStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            subtitle,
            style: blackFontStyle2,
          ),
          trailing: disableTrailing
              ? SizedBox()
              : trailing != null
                  ? trailing
                  : Icon(
                      Icons.arrow_forward_ios,
                      color: greyColor,
                    ),
        ),
      ),
    );
  }
}

class CustomListTile2 extends StatelessWidget {
  final IconData icon;
  final Widget trailing;
  final String title;
  final String subtitle;
  final Function onTap;
  final Color backgroundColor;
  final Color leadingColor;
  final bool disableTrailing;

  CustomListTile2(
      {@required this.icon,
      @required this.title,
      @required this.subtitle,
      @required this.onTap,
      this.trailing,
      this.backgroundColor,
      this.leadingColor,
      this.disableTrailing = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: backgroundColor != null ? backgroundColor : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 2,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.only(
            left: defaultMargin,
            right: defaultMargin,
            bottom: defaultMargin * 0.5),
        child: ListTile(
          leading: Icon(
            icon,
            color: leadingColor != null ? leadingColor : greyColor,
            size: 35,
          ),
          title: Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 50,
            child: Text(
              title,
              style: blackFontStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: blackFontStyle3,
          ),
          trailing: disableTrailing
              ? SizedBox()
              : trailing != null
                  ? trailing
                  : Icon(
                      Icons.arrow_forward_ios,
                      color: greyColor,
                    ),
        ),
      ),
    );
  }
}
