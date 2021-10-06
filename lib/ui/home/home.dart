import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:routes_pay/models/card_info_model.dart';
import 'package:routes_pay/models/shake_transition.dart';
import 'package:routes_pay/ui/transactions/transactions.dart';
import 'package:routes_pay/ui/widgets/nav-side-bar.dart';
import 'package:screen_brightness/screen_brightness.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool visibleCard = true;
  ScrollController? controller;
  bool scrollDone = false;
  List<CardInfo>? cardInfoList;
  double? positionX = 0;
  List pos = [0.0, 465.0, 540.0, 630.0, 740.0];
  int? indexOfCardOpen;

  int tapsCount = 0;

  @override
  void initState() {
    super.initState();
    setBrightness(0.9);

    if (Get.height < 730) {
      pos = [0.0, 340.0, 415.0, 505.0, 615.0];
    }
    getToken();
    controller = ScrollController();
    cardInfoList = [
      CardInfo(
        userName: "Monthly Pass",
        durationCard: '1 month',
        cardBalance: 15.000,
        busesNames: 'X1 , X2 ',
        expireDate:  DateFormat('yyyy-MM-dd')
            .format(DateTime.now().add(Duration(days: 30))),
        rightColor: Color.fromRGBO(36, 68, 148, 1),
        leftColor: Color.fromRGBO(12, 139, 199, 1),
      ),
      CardInfo(
        userName: "Monthly Pass",
        durationCard: '3 month',
        cardBalance: 35.000,
        busesNames: ' 66 , 101',
        expireDate:  DateFormat('yyyy-MM-dd')
            .format(DateTime.now().add(Duration(days: 90))),
        rightColor: Color.fromARGB(255, 224, 63, 92),
        leftColor: Color.fromARGB(255, 234, 94, 190),
      ),
      CardInfo(
        userName: "Weekly Pass",
        durationCard: '7 days',
        cardBalance: 3.000,
        busesNames: 'X1 ',
        expireDate:  DateFormat('yyyy-MM-dd')
            .format(DateTime.now().add(Duration(days: 7))),
        rightColor: Color.fromARGB(255, 171, 22, 75),
        leftColor: Color.fromARGB(255, 171, 51, 75),
      ),
      CardInfo(
        userName: "Daily Pass",
        durationCard: '1 day',
        cardBalance: 1.000,
        busesNames: ' X4 , 66 , 101',
        expireDate:  DateFormat('yyyy-MM-dd')
            .format(DateTime.now().add(Duration(days: 1))),
        rightColor: Color.fromARGB(255, 171, 155, 75),
        leftColor: Color.fromARGB(255, 244, 51, 75),
      ),
    ];

    _buildCards();
  }

  String? token;
  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = token;
    });
    print('Token : $token');
  }

//setBrightness
  Future<void> setBrightness(double brightness) async {
    try {
      await ScreenBrightness.setScreenBrightness(brightness);
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
          duration: Duration(milliseconds: 500),
          child: ShakeTransition(
            duration: Duration(seconds: i*2),
            offest: i.toDouble()*90,
            axis: Axis.vertical,
            child: SizedBox(
                height: Get.height * 0.6 - 50,
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
                          placeholder:'assets/images/routes_background.png'
                          , image: 'https://firebasestorage.googleapis.com/v0/b/routes-pay.appspot.com/o/routes_background.jpg?alt=media&token=c978d6d9-5f96-4c09-aa33-6159c3b2ea43'),
                    ),
                    direction: DismissDirection.endToStart,

                    onDismissed: (dir) {
                      Get.offAll(() => TransactionsScreen(),
                          arguments: {
                            'name': cardInfoList![i].userName
                          });
                    },
                    key: ValueKey(cardInfoList![i]),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (i == 0) {
                            setBrightness(1.0);

                            pos = [3.0, 460.0, 560.0, 660.0, 760.0];
                          } else {
                            setBrightness(1.0);

                            pos = [480.0, 580.0, 680.0, 780.0, 880.0];
                          }
                          pos[i] = 5.0 * i;
                          controller!.position.jumpTo(0.0);
                        });

                        if (i == indexOfCardOpen) {
                          Get.to(() => TransactionsScreen(),
                              arguments: {
                                'name': cardInfoList![i].userName
                              });
                          // tapsCount++;
                          // setBrightness(0.6);
                          // setState(() {
                          //   pos = [5.0, 100.0, 200.0, 300.0, 400.0];
                          // });
                          // visibleCard = false;
                          // print(tapsCount);
                          // print('back');

                        } else {
                          tapsCount = 0;
                        }
                        if (tapsCount > 1) {

                          setState(() {
                            if (i == 0) {
                              setBrightness(1.0);

                              pos = [5.0, 460.0, 560.0, 660.0, 760.0];
                            } else {
                              setBrightness(1.0);
                              pos = [460.0, 560.0, 660.0, 760.0, 860.0];
                            }
                            pos[i] = 5.0 * i;
                            controller!.position.jumpTo(0.0);
                            tapsCount = 0;
                          });
                        }
                        indexOfCardOpen = i;
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
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${cardInfoList![i].userName.toString()}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  Column(
                                    children: [

                                      Text(
                                        '${cardInfoList![i].cardBalance!.toStringAsFixed(3)} KD',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 22),
                                      ),
                                      Text(
                                        'Expire at : ${cardInfoList![i].expireDate!.toString()}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: Get.height * 0.1 - 50),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Buses Names :',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        '${cardInfoList![i].busesNames.toString()}',
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      Get.to(() => TransactionsScreen(),
                                          arguments: {
                                            'name': cardInfoList![i].userName
                                          });
                                    },
                                    icon: Icon(Icons.double_arrow_outlined),
                                    iconSize: 46,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                            Center(
                                child: SizedBox(
                              height: Get.height * 0.3 - 60,
                              child: QrImage(
                                data: 'google.com',
                                foregroundColor: Colors.white,
                              ),
                            )),
                            SizedBox(
                              height: Get.height * 0.1 - 50,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
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
    controller!.dispose();
  }

  void listenBottomCard() {
    final direction = controller!.position.userScrollDirection;
    if (controller!.position.pixels >= 20) {
      changePositionWithScroll();
    } else if (controller!.position.pixels <= -20) {
      changePositionWithScroll2();
    }
  }

  changePositionWithScroll() {
    scrollDone = true;
    controller!.position.jumpTo(0.0);
  }

  changePositionWithScroll2() {
    if (scrollDone) {
      setState(() {});
      scrollDone = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideNavBar(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Routes Pay',
            style: TextStyle(
                fontFamily: 'Montserrat-Arabic Regular', fontSize: 28)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(36, 68, 148, 1),
      ),
      body: ListView(
          controller: controller,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            SizedBox(
              height: Get.height * 0.1 - 70,
            ),
            SizedBox(
              height: 1200,
              child: Container(
                color: Colors.grey.shade50,
                child: Stack(alignment: Alignment.center, children: [
                  ..._buildCards(),
                ]),
              ),
            ),
          ]),
    );
  }
}
