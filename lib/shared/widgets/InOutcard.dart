part of '../shared.dart';

// ignore: must_be_immutable
class InOutCard extends StatelessWidget {
  final PendingInOut data;
  InOutCard({this.data});

  Size size;
  @override
  Widget build(BuildContext context) {
    data.printAllData();
    size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: defaultMargin),
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: mainColor,
              ),
              Container(
                  height: 160,
                  width: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                    color: mainColor,
                  )),
            ],
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            padding: EdgeInsets.only(top: 10),
            constraints: BoxConstraints(
              maxWidth: 340,
              minHeight: 80,
              maxHeight: 135,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: Icon(MdiIcons.inboxArrowDown,
                          color: blueGeneralUse, size: 50),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${data.colProductRegistration}',
                            maxLines: 2,
                            style: blackFontStyle,
                            overflow: TextOverflow.ellipsis),
                        Text(data.locator.locatorName, style: blackFontStyle2),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 5, horizontal: 2.5),
                          child: Text(
                            data.colStatus,
                            style: blackFontStyle3,
                          ),
                          decoration: BoxDecoration(
                              color: getCardColorStatus(status: data.colStatus),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              )),
                        ),
                        Text('Submitted at : ${data.getSubmitTimeSTR()}'),
                      ],
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: Colors.black12.withOpacity(0.05),
                  ),
                  constraints: BoxConstraints(
                    maxWidth: 340,
                    maxHeight: 30,
                  ),
                  child: Text(
                    'Click here to see details',
                    style: greyFontStyle.copyWith(color: Colors.blue),
                  ),
                ),
              ],
            ),
            // margin: EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(5, 5), // changes position of shadow
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  Color getCardColorStatus({@required status}) {
    switch (status) {
      case 'pending':
        return mainColor;
      case 'ERROR : Idempiere ERROR':
        return Colors.red;
      case 'ERROR : File not found':
        return Colors.red;
      case 'Uploaded':
        return Colors.green;
      default:
        return Colors.pink;
    }
  }
}

// ignore: must_be_immutable
class InOutBranchCard extends StatelessWidget {
  final PendingInOutBranch data;
  InOutBranchCard({this.data});

  Size size;
  @override
  Widget build(BuildContext context) {
    data.printAllData();
    size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: defaultMargin),
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: mainColor,
              ),
              Container(
                  height: 160,
                  width: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                    color: mainColor,
                  )),
            ],
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            padding: EdgeInsets.only(top: 10),
            constraints: BoxConstraints(
              maxWidth: 340,
              minHeight: 80,
              maxHeight: 135,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: Icon(MdiIcons.inboxArrowDown,
                          color: blueGeneralUse, size: 50),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${data.colProductRegistration}',
                            maxLines: 2,
                            style: blackFontStyle,
                            overflow: TextOverflow.ellipsis),
                        Text(data.locator.locatorName, style: blackFontStyle2),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 5, horizontal: 2.5),
                          child: Text(
                            data.colStatus,
                            style: blackFontStyle3,
                          ),
                          decoration: BoxDecoration(
                              color: getCardColorStatus(status: data.colStatus),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              )),
                        ),
                        Text('Submitted at : ${data.getSubmitTimeSTR()}'),
                      ],
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: Colors.black12.withOpacity(0.05),
                  ),
                  constraints: BoxConstraints(
                    maxWidth: 340,
                    maxHeight: 30,
                  ),
                  child: Text(
                    'Click here to see details',
                    style: greyFontStyle.copyWith(color: Colors.blue),
                  ),
                ),
              ],
            ),
            // margin: EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(5, 5), // changes position of shadow
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  Color getCardColorStatus({@required status}) {
    switch (status) {
      case 'pending':
        return mainColor;
      case 'ERROR : Idempiere ERROR':
        return Colors.red;
      case 'ERROR : File not found':
        return Colors.red;
      case 'Uploaded':
        return Colors.green;
      default:
        return Colors.pink;
    }
  }
}

// ignore: must_be_immutable
class InOutWarehouseCard extends StatelessWidget {
  final PendingInOutWarehouse data;
  InOutWarehouseCard({this.data});

  Size size;
  @override
  Widget build(BuildContext context) {
    data.printAllData();
    size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: defaultMargin),
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: mainColor,
              ),
              Container(
                  height: 160,
                  width: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                    color: mainColor,
                  )),
            ],
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            padding: EdgeInsets.only(top: 10),
            constraints: BoxConstraints(
              maxWidth: 340,
              minHeight: 80,
              maxHeight: 135,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: Icon(MdiIcons.inboxArrowDown,
                          color: blueGeneralUse, size: 50),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${data.colProductRegistration}',
                            maxLines: 2,
                            style: blackFontStyle,
                            overflow: TextOverflow.ellipsis),
                        Text(data.locator.locatorName, style: blackFontStyle2),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 5, horizontal: 2.5),
                          child: Text(
                            data.colStatus,
                            style: blackFontStyle3,
                          ),
                          decoration: BoxDecoration(
                              color: getCardColorStatus(status: data.colStatus),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              )),
                        ),
                        Text('Submitted at : ${data.getSubmitTimeSTR()}'),
                      ],
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: Colors.black12.withOpacity(0.05),
                  ),
                  constraints: BoxConstraints(
                    maxWidth: 340,
                    maxHeight: 30,
                  ),
                  child: Text(
                    'Click here to see details',
                    style: greyFontStyle.copyWith(color: Colors.blue),
                  ),
                ),
              ],
            ),
            // margin: EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(5, 5), // changes position of shadow
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  Color getCardColorStatus({@required status}) {
    switch (status) {
      case 'pending':
        return mainColor;
      case 'ERROR : Idempiere ERROR':
        return Colors.red;
      case 'ERROR : File not found':
        return Colors.red;
      case 'Uploaded':
        return Colors.green;
      default:
        return Colors.pink;
    }
  }
}

class InOutWarehouseBranchCard extends StatelessWidget {
  final PendingInOutWarehouseBranch data;
  InOutWarehouseBranchCard({this.data});

  Size size;
  @override
  Widget build(BuildContext context) {
    data.printAllData();
    size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: defaultMargin),
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: mainColor,
              ),
              Container(
                  height: 160,
                  width: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                    color: mainColor,
                  )),
            ],
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            padding: EdgeInsets.only(top: 10),
            constraints: BoxConstraints(
              maxWidth: 340,
              minHeight: 80,
              maxHeight: 135,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: Icon(MdiIcons.inboxArrowDown,
                          color: blueGeneralUse, size: 50),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${data.colProductRegistration}',
                            maxLines: 2,
                            style: blackFontStyle,
                            overflow: TextOverflow.ellipsis),
                        Text(data.locator.locatorName, style: blackFontStyle2),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 5, horizontal: 2.5),
                          child: Text(
                            data.colStatus,
                            style: blackFontStyle3,
                          ),
                          decoration: BoxDecoration(
                              color: getCardColorStatus(status: data.colStatus),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              )),
                        ),
                        Text('Submitted at : ${data.getSubmitTimeSTR()}'),
                      ],
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: Colors.black12.withOpacity(0.05),
                  ),
                  constraints: BoxConstraints(
                    maxWidth: 340,
                    maxHeight: 30,
                  ),
                  child: Text(
                    'Click here to see details',
                    style: greyFontStyle.copyWith(color: Colors.blue),
                  ),
                ),
              ],
            ),
            // margin: EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(5, 5), // changes position of shadow
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  Color getCardColorStatus({@required status}) {
    switch (status) {
      case 'pending':
        return mainColor;
      case 'ERROR : Idempiere ERROR':
        return Colors.red;
      case 'ERROR : File not found':
        return Colors.red;
      case 'Uploaded':
        return Colors.green;
      default:
        return Colors.pink;
    }
  }
}

// ignore: must_be_immutable

