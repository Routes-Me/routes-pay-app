import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:routes_pay/ui/widgets/nav-side-bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool visible = true;
  double cardStatus = 300;
  double secondContainerPosShow = 0;
  double secondContainerPosHide = 300;
  double secondContainerPosFullHide = 740;
  ScrollController? controller;
  bool secondContainerShow = false;
  bool firstContainerShow = false;
  bool scrollDone = false;

  @override
  void initState() {
    super.initState();
    getToken();
    controller = ScrollController();
    controller!.addListener(listenBottomCard);
  }

  String? token;

  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = token;
    });
    print('Token : $token');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.removeListener(listenBottomCard);
    controller!.dispose();
  }

  void listenBottomCard() {
    //final direction = controller.position.userScrollDirection;
    if (controller!.position.pixels >= 20) {
      print(controller!.position.pixels);
      changePositionWithScroll();
    } else if (controller!.position.pixels <= -20) {
      changePositionWithScroll2();
    }
  }

  changePositionWithScroll() {
    if (cardStatus > 0) {
      setState(() {
        cardStatus = 0;
      });
      scrollDone = true;
      controller!.position.jumpTo(0.0);
    }
  }

  changePositionWithScroll2() {
    if (scrollDone) {
      setState(() {
        cardStatus = 300;
      });
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
                fontFamily: 'Montserrat-Arabic Regular', fontSize: 32)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(36, 68, 148, 1),
      ),
      body: Padding(
        padding:  EdgeInsets.only(top:Get.height *0.1 -80),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey.shade50,
          child: Stack(children: [
            AnimatedPositioned(
              top: secondContainerShow ? 0 : 0,
              duration: Duration(milliseconds:400),
              child: SizedBox(
                  height: 600,
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          secondContainerShow = !secondContainerShow;
                          cardStatus = secondContainerShow
                              ? secondContainerPosFullHide
                              : secondContainerPosHide;
                        });
                      },
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Container(
                            height: 550,
                            decoration: BoxDecoration(
                                border: Border.all(width: 0.9),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(14),
                                  topRight: Radius.circular(14),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                //color: Colors.yellow.shade300.withOpacity(0.9),
                                gradient: const LinearGradient(
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                    colors: [
                                      Color.fromRGBO(36, 68, 148, 1),
                                      Color.fromRGBO(12, 139, 199, 1),
                                    ])),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Card Holder Name',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      Text(
                                        '3333',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Center(
                                      child: SizedBox(
                                    height: 200,
                                    child: QrImage(
                                      data: 'google.com',
                                      foregroundColor: Colors.white,
                                    ),
                                  )),
                                  SizedBox(
                                    height: 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            AnimatedPositioned(
              top: cardStatus,
              duration: Duration(milliseconds: 400),
              child: SizedBox(
                  height: 600,
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          firstContainerShow = !firstContainerShow;
                          cardStatus = firstContainerShow
                              ? secondContainerPosShow
                              : secondContainerPosHide;
                          scrollDone = true;
                        });
                      },
                      child: ListView(
                        controller: controller,
                        physics: BouncingScrollPhysics(),
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    Color.fromRGBO(36, 68, 148, 1),
                                    Color.fromRGBO(12, 139, 199, 1),
                                  ]),
                              border: Border.all(width: 0.9),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.yellow.shade300,
                            ),
                            height: 550,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'New Card',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      Text(
                                        '33452',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text('Buses Names :',style: TextStyle(
                                            color: Colors.white
                                          ),),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            'X1 , X2 , 50 , X4 , 66 , 101',
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 300,
                          )
                        ],
                      ),
                    ),
                  )),
            ),

          ]),
        ),
      ),
    );
  }
}
