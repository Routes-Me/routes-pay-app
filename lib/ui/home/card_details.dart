import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:routes_pay/data/transaction_data.dart';
import 'package:routes_pay/models/shake_transition.dart';
import 'package:routes_pay/ui/payment/transactions/transaction_card.dart';
import 'package:routes_pay/ui/widgets/payment_method_dialog.dart';
import 'package:screen_brightness/screen_brightness.dart';

import '../recharge_screen.dart';

class CardDetails extends StatefulWidget {
  final cardInfo;
  final double? cardPosition;

  const CardDetails({Key? key,this.cardInfo,this.cardPosition}) : super(key: key);

  @override
  _CardDetailsState createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  ScrollController? controller;
  bool scrollDone = false;
  double? cardPos =600.0;
  double? listTransPos =600.0;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    controller!.addListener(listenBottomCard);
   Timer(Duration(milliseconds: 5),()=> setState(() {
     cardPos =0.0;
     setBrightness(1.0);
   }));
    Timer(Duration(milliseconds: 155),()=> setState(() {
      listTransPos =420.0;
    }));
  }
  void listenBottomCard() {
    if (controller!.position.pixels >= 70) {
    } else if (controller!.position.pixels <= -90) {
      changePositionWithScroll();
    }
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
  changePositionWithScroll() {
    scrollDone = true;
   Get.back();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( centerTitle: true,
        title: Text('details_title'.tr,style: TextStyle(
          fontSize: 22,
          color: widget.cardInfo.leftColor,
        ),),
        foregroundColor: widget.cardInfo.leftColor,
      actions: [
        TextButton(onPressed: (){
          showD(context,widget.cardInfo);
        }, child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text('btn_recharge'.tr,style: TextStyle(
            fontSize: 14,
            color: widget.cardInfo.leftColor
          ),),
        ))
      ],
      ),
      body: ListView(
        controller: controller,
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height:Get.height +500,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  top: cardPos,
                  child: Container(
                    height:394,
                    width: Get.width -30,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            widget.cardInfo.rightColor!,
                            widget.cardInfo.leftColor!
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
                                  '${widget.cardInfo.userName.toString()}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${widget.cardInfo.cardBalance!.toStringAsFixed(3)} K.D',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  ),
                                  Text(
                                    'Expire at : ${widget.cardInfo.expireDate!.toString()}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Buses Names :',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    '${widget.cardInfo.busesNames.toString()}',
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
                       Padding(
                         padding: const EdgeInsets.only(bottom: 16.0),
                         child: SizedBox(
                            height: 205,
                            child: Center(
                              child: QrImage(
                                data: 'google.com',
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                       ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    top: listTransPos,
                    child: SizedBox(
                      width: Get.width - 20,
                      height: 1200,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
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
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
