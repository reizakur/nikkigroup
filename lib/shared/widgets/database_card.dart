part of '../shared.dart';

// ignore: must_be_immutable
class DatabaseCard extends StatelessWidget {
  Size size;
  final String title;
  final String lastUpdate;
  final String dataLength;
  final Function onTap;

  DatabaseCard(
      {@required this.title,
      @required this.lastUpdate,
      @required this.dataLength,
      @required this.onTap});

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      height: 120,
      width: size.width,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 2,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, bottom: 5),
                    child: Text(
                      title,
                      style: blackFontStyle,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        MdiIcons.clock,
                        color: greyColor,
                        size: 20,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        lastUpdate != null
                            ? 'Last update : $lastUpdate'
                            : 'Last update : None',
                        style: blackFontStyle2,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 40,
                width: 80,
                child: ElevatedButton(
                  onPressed: () {
                    onTap();
                  },
                  child: Text(
                    'Action',
                    style: blackFontStyle2.copyWith(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                      backgroundColor:
                          MaterialStateProperty.all(blueGeneralUse)),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                MdiIcons.database,
                color: greyColor,
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$dataLength Data(s)',
                    style: blackFontStyle3.copyWith(color: greyColor),
                  ),
                  Text(
                    'on your device',
                    style: greyFontStyle,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
