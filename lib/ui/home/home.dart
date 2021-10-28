import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:routes_pay/data/transaction_data.dart';
import 'package:routes_pay/encrption/AES.dart';
import 'package:routes_pay/models/card_info_model.dart';
import 'package:routes_pay/models/shake_transition.dart';
import 'package:routes_pay/payment/check_out.dart';
import 'package:routes_pay/ui/home/card_details.dart';
import 'package:routes_pay/ui/payment/transactions/transaction_card.dart';
import 'package:routes_pay/ui/widgets/nav-side-bar.dart';
import 'package:screen_brightness/screen_brightness.dart';

import '../recharge_screen.dart';

class Home extends StatefulWidget {
  final zoomDrawerController ;

  const Home(this.zoomDrawerController) ;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool visibleCard = true;
  ScrollController? controller;
  bool scrollDone = false;
  List<CardInfo>? cardInfoList;
  double? positionX = 0;
  List pos = [3.0, 90.0, 180.0, 270.0, 360.0, 450.0, 540.0];
  List height = [364.0, 364.0, 364.0, 364.0, 364.0, 364.0, 364.0];

  int? indexOfCardOpen;
  bool transactionsShow = false;

  int tapsCount = 0;
  bool showQRCode = false;
  double heightOfQRImage = Get.height * 0.3 - 70;

  @override
  void initState() {
    super.initState();
    if (Get.height < 730) {
      pos = [0.0, 90.0, 180.0, 270.0, 360.0, 450.0, 530.0];
      heightOfQRImage = Get.height * 0.3 - 90;
    }
    getToken();
    cardInfoList = [
      CardInfo(
        userName: "Monthly Pass",
        durationCard: '1 month',
        cardBalance: 15.000,
        busesNames: 'X1 , X2 ',
        expireDate: DateFormat('yyyy-MM-dd')
            .format(DateTime.now().add(Duration(days: 30))),
        rightColor: Color.fromRGBO(36, 68, 148, 1),
        leftColor: Color.fromRGBO(12, 139, 199, 1),
      ),
      CardInfo(
        userName: "Monthly Pass",
        durationCard: '3 month',
        cardBalance: 35.000,
        busesNames: ' 66 , 101',
        expireDate: DateFormat('yyyy-MM-dd')
            .format(DateTime.now().add(Duration(days: 90))),
        rightColor: Color.fromARGB(255, 224, 63, 92),
        leftColor: Color.fromARGB(255, 234, 94, 190),
      ),
      CardInfo(
        userName: "Weekly Pass",
        durationCard: '7 days',
        cardBalance: 3.000,
        busesNames: 'X1 ',
        expireDate: DateFormat('yyyy-MM-dd')
            .format(DateTime.now().add(Duration(days: 7))),
        rightColor: Color.fromARGB(255, 171, 22, 75),
        leftColor: Color.fromARGB(255, 191, 81, 75),
      ),
      // CardInfo(
      //   userName: "Daily Pass",
      //   durationCard: '1 day',
      //   cardBalance: 1.000,
      //   busesNames: ' X4 , 66 , 101',
      //   expireDate: DateFormat('yyyy-MM-dd')
      //       .format(DateTime.now().add(Duration(days: 1))),
      //   rightColor: Color.fromARGB(255, 171, 155, 75),
      //   leftColor: Color.fromARGB(255, 244, 51, 75),
      // ),
      CardInfo(
        userName: "Daily Pass",
        durationCard: '3 day',
        cardBalance: 2.000,
        busesNames: ' X2 , 55 , 101',
        expireDate: DateFormat('yyyy-MM-dd')
            .format(DateTime.now().add(Duration(days: 3))),
        rightColor: Color.fromARGB(255, 014, 51, 75),
        leftColor: Color.fromARGB(255, 31, 155, 75),
      ),
    ];

    _buildCards();
  }

  String? token;

  getToken() async {
    token = await FirebaseMessaging.instance.getToken();

      token = token;
    print('Token : $token');
  }

//setBrightness
  Future<void> setBrightness(double brightness) async {
    try {
      await ScreenBrightness().setScreenBrightness(brightness);
    } catch (e) {
      print(e);
      throw 'Failed to set brightness';
    }
  }

  _buildCards() {
    List widgetList = [];
    for (int i = 0; i < cardInfoList!.length; i++) {
      widgetList.add(
        AnimatedPositioned(
          top: pos[i],
          duration: Duration(milliseconds: 300),
          child: ShakeTransition(
            duration: Duration(seconds: i * 1),
            offest: i.toDouble() * 90,
            axis: Axis.vertical,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 10),
              height: height[i],
              child: SizedBox(
                  height: Get.height * 0.5 - 136,
                  width: Get.width - 25,
                  child: Card(
                    elevation: 9,
                    color: Colors.white.withOpacity(0.0),
                    child: Dismissible(
                      background: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: FadeInImage.assetNetwork(
                            imageScale: 1,
                            height: Get.height * 0.6 - 50,
                            fit: BoxFit.fill,
                            placeholder: 'assets/images/routes_background.png',
                            image:
                                'https://firebasestorage.googleapis.com/v0/b/routes-pay.appspot.com/o/routes_background.jpg?alt=media&token=c978d6d9-5f96-4c09-aa33-6159c3b2ea43'),
                      ),
                      direction: DismissDirection.endToStart,
                      // onDismissed: (dir) {
                      //   Get.offAll(() => TransactionsScreen(), arguments: {
                      //     'name': cardInfoList![i].userName,
                      //     'dismissed': true
                      //   });
                      // },
                      key: ValueKey(cardInfoList![i]),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (
                                BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                              ) {
                                return CardDetails(
                                  cardInfo: cardInfoList![i],
                                  cardPosition: pos[i],
                                );
                              },
                              transitionsBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation,
                                  Widget child) {
                                return SlideTransition(
                                  position: new Tween<Offset>(
                                    begin: const Offset(-0.0, 1.0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: new SlideTransition(
                                    position: new Tween<Offset>(
                                      begin: Offset.zero,
                                      end: const Offset(-1.0, 0.0),
                                    ).animate(secondaryAnimation),
                                    child: child,
                                  ),
                                );
                              },
                              transitionDuration: Duration(milliseconds: 2),

                            ),
                          );

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  cardInfoList![i].rightColor!,
                                  cardInfoList![i].leftColor!
                                ]),
                            border: Border.all(width: 0.9),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 12.0,
                                    right: 18.0,
                                    left: 12.0,
                                    bottom: 2),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Text(
                                        '${cardInfoList![i].userName.toString()}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 22),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${cardInfoList![i].cardBalance!.toStringAsFixed(3)} KD',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22),
                                        ),
                                        Text(
                                          'Expire at : ${cardInfoList![i].expireDate!.toString()}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 12.0,
                                    left: 12.0,
                                    right: 12.0,
                                    bottom: 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Buses Names :',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          '${cardInfoList![i].busesNames.toString()}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              showQRCode
                                  ? SizedBox(
                                      height: 180,
                                      child: Center(
                                        child: QrImage(
                                          data: 'google.com',
                                          foregroundColor: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
          ),
        ),
      );
    }
    return widgetList;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(controller !=null){
      controller!.dispose();
    }
  }

  void listenBottomCard() {
    if (controller!.position.pixels >= 60) {
    } else if (controller!.position.pixels <= -90) {
      print('aa');
      changePositionWithScroll();
    }
  }

  changePositionWithScroll() {
    scrollDone = true;
    setState(() {
      height = [364.0, 364.0, 364.0, 364.0, 364.0, 364.0, 364.0];
      transactionsShow = false;
      showQRCode = false;
      tapsCount = 1;
      pos = [3.0, 90.0, 180.0, 270.0, 360.0, 450.0, 540.0];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(Get.height * 0.5 - 136);
    AESEncryption encryption = new AESEncryption();

    // var en = encryption.encryptMsg('khaled').base16;
    // print(en);
    // var dec = encryption.decryptMsg(encryption.getCode(en)).toString();
    // print(dec);

    return Scaffold(
      drawer: SideNavBar(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Routes Pay',
            style: TextStyle(
                fontFamily: 'Montserrat-Arabic Regular', fontSize: 24)),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        leading: InkWell(
          onTap: (){
            widget.zoomDrawerController.toggle();
          },
          child: Icon(Icons.menu),),
      ),
      body: ListView(
          controller: controller,
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: Get.height + 250,
              child: Container(
                color: Colors.grey.shade50,
                child: Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: Stack(alignment: Alignment.center, children: [
                    ..._buildCards(),
                    AnimatedContainer(
                      transformAlignment: Alignment.bottomRight,
                      duration: Duration(milliseconds: 300),
                      height: transactionsShow ? 420.0 : 0.0001,
                      child: SizedBox(
                        width: Get.width - 30,
                        child: ListView.separated(
                            itemCount: myTransactions.length,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 3.0,
                              );
                            },
                            itemBuilder: (context, index) {
                              return ShakeTransition(
                                  axis: Axis.vertical,
                                  offest: index.toDouble() * 40,
                                  duration: Duration(milliseconds: index * 300),
                                  child: TransactionCard(
                                      transaction: myTransactions[index]));
                            }),
                      ),
                    )
                  ]),
                ),
              ),
            ),
          ]),
    );
  }
}
