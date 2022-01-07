part of '../shared.dart';

class SimpleListTile extends StatelessWidget {
  final Function onTap;
  final String title;
  final Widget subtitle;
  final Widget trailing;
  final Widget leading;
  final Color color;

  const SimpleListTile({
    Key key,
    @required this.onTap,
    @required this.title,
    @required this.subtitle,
    @required this.trailing,
    @required this.leading,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border(
            bottom: BorderSide(
          color: blueGeneralUse,
          width: 1,
        )),
      ),
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: ListTile(
        onTap: () {
          onTap();
        },
        title: Text(title, style: blackFontStyle),
        subtitle: subtitle,
        trailing: trailing,
        leading: leading,
      ),
    );
  }
}
