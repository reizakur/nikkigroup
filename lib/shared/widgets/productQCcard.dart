part of '../shared.dart';

// ignore: must_be_immutable
class ProductQCcard extends StatelessWidget {
  final PendingProductQC data;
  ProductQCcard({this.data});

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
              minHeight: 150,
              maxHeight: 150,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      data.colImagePath != 'No Image'
                          ? Container(
                              height: 80,
                              width: 80,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  image: DecorationImage(
                                      image: FileImage(File(data.colImagePath)),
                                      fit: BoxFit.contain),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            )
                          : Container(
                              height: 80,
                              width: 80,
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(
                                MdiIcons.imageAlbum,
                                color: Colors.white,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: 200,
                              minWidth: 100,
                              maxHeight: 50,
                            ),
                            child: Text(
                              data.product.productName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: blackFontStyle,
                            ),
                          ),
                          Text(data.colProductStatus,
                              style: blackFontStyle2.copyWith(
                                  color: data.colProductStatus == 'Accepted'
                                      ? Colors.green
                                      : Colors.red)),
                          Text('Submitted at : ${data.getSubmitTimeSTR()}'),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 2.5),
                            child: Text(
                              data.colStatus,
                              style:
                                  blackFontStyle3.copyWith(color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                                color:
                                    getCardColorStatus(status: data.colStatus),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
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
                //color: ConstVal.defaultWhite,
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
        return Colors.deepOrange;
      case 'ERROR : Idempiere':
        return Colors.red;
      case 'ERROR : Network':
        return Colors.red;
      case 'ERROR : File not found':
        return Colors.red;
      case 'Uploaded':
        return Colors.green;
      default:
        return Colors.yellow;
    }
  }
}

// ignore: must_be_immutable
class ProductQCBranchcard extends StatelessWidget {
  final PendingProductQCBranch data;
  ProductQCBranchcard({this.data});

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
              minHeight: 150,
              maxHeight: 150,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      data.colImagePath == 'No Image'
                          ? Container(
                              height: 80,
                              width: 80,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            )
                          : Container(
                              height: 80,
                              width: 80,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  image: DecorationImage(
                                      image: FileImage(File(data.colImagePath)),
                                      fit: BoxFit.contain),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: 200,
                              minWidth: 100,
                              maxHeight: 50,
                            ),
                            child: Text(
                              data.product.productName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: blackFontStyle,
                            ),
                          ),
                          Text(data.colProductStatus,
                              style: blackFontStyle2.copyWith(
                                  color: data.colProductStatus == 'Accepted'
                                      ? Colors.green
                                      : Colors.red)),
                          Text('Submitted at : ${data.getSubmitTimeSTR()}'),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 2.5),
                            child: Text(
                              data.colStatus,
                              style:
                                  blackFontStyle3.copyWith(color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                                color:
                                    getCardColorStatus(status: data.colStatus),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
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
                //color: ConstVal.defaultWhite,
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
        return Colors.deepOrange;
      case 'ERROR : Idempiere':
        return Colors.red;
      case 'ERROR : File not found':
        return Colors.red;
      case 'Uploaded':
        return Colors.green;
      default:
        return Colors.yellow;
    }
  }
}
