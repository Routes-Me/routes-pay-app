import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:routes_pay/ui/transactions/transactions.dart';
import 'package:routes_pay/ui/viewmodel/cards_model.dart';

class CreditCards extends StatefulWidget {
  const CreditCards({Key? key}) : super(key: key);

  @override
  _CreditCardsState createState() => _CreditCardsState();
}

class _CreditCardsState extends State<CreditCards> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          color: Color.fromARGB(255, 230, 228, 232),
          child: CardsSlider(
            height: MediaQuery.of(context).size.height * 0.7,
          ),
        ),

    );
  }
}

class CardsSlider extends StatefulWidget {
  final double? height;

  const CardsSlider({Key? key, this.height}) : super(key: key);

  @override
  _CardsSliderState createState() => _CardsSliderState();
}

class _CardsSliderState extends State<CardsSlider> {
  double? positionY_line1;
  double? positionY_line2;
  double? _midleAreaHeight;
  double? _outSideCardInterval;
  double? scrollOffsetY;
  List<CardInfo>? cardInfoList;
  int? currentIndexOfCard = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //space

    positionY_line1 = widget.height! * 0.1;
    positionY_line2 = positionY_line1! + Get.height > 720 ?265 : 225;

    _midleAreaHeight = positionY_line2! - positionY_line1!;
    _outSideCardInterval = 30.0;
    scrollOffsetY = 0;
    cardInfoList = [
      CardInfo(
        userName: "KHALED SALEH",
        rightColor: Color.fromARGB(255, 85, 137, 234),
        leftColor: Color.fromARGB(255, 85, 137, 234),
      ),
      CardInfo(
        userName: "KHALED SALEH 1",
        rightColor: Color.fromARGB(255, 224, 63, 92),
        leftColor: Color.fromARGB(255, 234, 94, 190),
      ),
      CardInfo(
        userName: "KHALED SALEH 2",
        rightColor: Color.fromARGB(255, 171, 51, 75),
        leftColor: Color.fromARGB(255, 171, 51, 75),
      ),
      CardInfo(
        userName: "KHALED SALEH 3",
        rightColor: Color.fromARGB(255, 22, 22, 111),
        leftColor: Color.fromARGB(255, 22, 22, 22),
      ),

    ];

    for (var i = 0; i < cardInfoList!.length; i++) {
      CardInfo cardInfo = cardInfoList![i];
      if (i == 0) {
        cardInfo.positionY = positionY_line1! ;
        cardInfo.opacity = 1.0;
        cardInfo.scale = 1.0;
        cardInfo.rotate = 1.0;
      } else {
        cardInfo.positionY = positionY_line2! + (i - 1) * 30;
        cardInfo.opacity = 0.7 - (i - 1) * 0.1;
        cardInfo.scale = 0.9;
        cardInfo.rotate = -60;
      }
    }
    cardInfoList = cardInfoList!.reversed.toList();
  }
  //change card name state
  changeName(){
    if(currentIndexOfCard! <= cardInfoList!.length){
      Provider.of<CardsModel>(context,listen: false).changeCardName(cardInfoList![currentIndexOfCard!].userName!);

    }


  }
  _buildCards() {

    List widgetList = [];
    for (CardInfo cardInfo in cardInfoList!) {
      widgetList.add(Positioned(
        //all cards pos h
        top:Get.height >690 ? cardInfo.positionY!  +40 :cardInfo.positionY!  -15 ,
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(pi / 180 * cardInfo.rotate!)
            ..scale(cardInfo.scale),
          alignment: Alignment.topCenter,
          child: Opacity(
            opacity: cardInfo.opacity!,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.3),blurRadius: 10,offset: Offset(5, 10))
                ],
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.red,
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [cardInfo.leftColor!, cardInfo.rightColor!])),
              //Size of cards
              width: Get.width *0.9+10,
              height: Get.height >690 ?Get.height *0.3 -50 :Get.height *0.3 ,
              child: Stack(
                children: [
                  //number
                  const Positioned(
                    top: 120,
                    left: 20,
                    child: Text(
                      '4423',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                  //user name
                  Positioned(
                    top: 150,
                    left: 20,
                    child: Text(
                      cardInfo.userName!,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),

                   Positioned(
                      right: 4,
                      bottom: 4,
                      child: Consumer<CardsModel>(
                        builder: (context,data,_)=> Container(
                          height:Get.height >620? Get.height * 0.2+20:Get.height * 0.3,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: QrImage(
                              foregroundColor: Colors.white,
                              //eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.square,color: Colors.deepOrange),
                             // backgroundColor: Colors.white,
                              data: data.cardName! ,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ));
    }
    return widgetList;
  }

  //update cards
  _updateCardsPosition(double offsetY){

    void updatePosition(CardInfo cardInfo ,double firstCardAtAreaIdx ,int cardIndex ){
      double currentCardAtAreaIdx = firstCardAtAreaIdx + cardIndex ;
      if(currentCardAtAreaIdx < 0){
        cardInfo.positionY = positionY_line1! + currentCardAtAreaIdx* _outSideCardInterval!;

        cardInfo.rotate = -90.0/ 30*(positionY_line1!-cardInfo.positionY!);
        if(cardInfo.rotate! >0.0)cardInfo.rotate = 0.0;
        if(cardInfo.rotate!< -90.0)cardInfo.rotate = -90.0;

        cardInfo.scale = 1.0 - 0.2/30*(positionY_line1!-cardInfo.positionY!);
        if(cardInfo.scale! < 0.8) cardInfo.scale = 0.8;
        if(cardInfo.scale! > 1.0) cardInfo.scale = 1.0;

        //1.0 -> 0.7
        cardInfo.opacity =1.0 - 0.7/30*(positionY_line1!-cardInfo.positionY!);
        if(cardInfo.opacity! < 0.0)cardInfo.opacity = 0.0;
        if(cardInfo.opacity! > 1.0)cardInfo.opacity = 1.0;


      }else if(currentCardAtAreaIdx>=0 && currentCardAtAreaIdx<1){
        //movie 1:1
        cardInfo.positionY = positionY_line1! + currentCardAtAreaIdx* _midleAreaHeight!;

        cardInfo.rotate = -60.0/ (positionY_line2! - positionY_line1!)*(cardInfo.positionY! - positionY_line1!);
        if(cardInfo.rotate!>0.0)cardInfo.rotate =0.0;
        if(cardInfo.rotate!< -60.0)cardInfo.rotate = -60.0;

        //0.9 ==>1.0
        cardInfo.scale = 1.0 - 0.1/(positionY_line2!- positionY_line1!)*(cardInfo.positionY! - positionY_line1!);
        if(cardInfo.scale! < 0.9) cardInfo.scale = 0.9;
        if(cardInfo.scale! > 1.0) cardInfo.scale = 1.0;

        //0.7 -> 1.0
        cardInfo.opacity =1.0 - 0.3/(positionY_line2!-positionY_line1!)*(cardInfo.positionY! - positionY_line1!);
        if(cardInfo.opacity! < 0.0)cardInfo.opacity = 0.0;
        if(cardInfo.opacity! > 1.0)cardInfo.opacity = 1.0;

      }else if(currentCardAtAreaIdx >= 1){
        cardInfo.positionY = positionY_line2! + (currentCardAtAreaIdx-1)* _outSideCardInterval!;

        cardInfo.rotate = -60.0;
        cardInfo.scale = 0.9;
        cardInfo.opacity = 0.7 - cardIndex*0.1;
      }
      if(currentCardAtAreaIdx <cardInfoList!.length){
        currentIndexOfCard = currentCardAtAreaIdx.toInt();
      }
    }

    scrollOffsetY = scrollOffsetY! + offsetY;
    double firstCardAtAreaIdx = scrollOffsetY! / _midleAreaHeight! ;
   // print(firstCardAtAreaIdx);


    for (var i = 0; i < cardInfoList!.length; i++) {
      CardInfo cardInfo = cardInfoList![cardInfoList!.length-1 -i];

      updatePosition(cardInfo, firstCardAtAreaIdx, i);

    }

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    print(' h ${Get.height}');
    return GestureDetector(
      onTap: (){
        Get.to(()=>TransactionsScreen(),arguments: {'name':cardInfoList![currentIndexOfCard!].userName});
      },
      onVerticalDragUpdate: (DragUpdateDetails d){
          if(currentIndexOfCard! <= cardInfoList!.length){
            _updateCardsPosition(d.delta.dy);
          }
      },
      onVerticalDragEnd: (DragEndDetails d){
        scrollOffsetY = (scrollOffsetY!/_midleAreaHeight!).round()*_midleAreaHeight!;
        if(currentIndexOfCard! <= cardInfoList!.length){
          _updateCardsPosition(0);
          changeName();
        }
        print(currentIndexOfCard);
      },

      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding:  EdgeInsets.only(top:screenSize.height >690 ? screenSize.height *0.1-30:screenSize.height *0.1-58,),
                child: Text(
                  'YOUR CARDS',
                  style: TextStyle(fontSize: 17, color: Colors.grey.shade700),
                ),
              ),
            ),
            ..._buildCards(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: screenSize.height*0.2,
                decoration: const BoxDecoration(
                    color: Colors.yellow,
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(0, 255, 255, 255),
                          Color.fromARGB(0, 255, 2555, 255)
                        ])),
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: screenSize.height *0.1-16,

                      child: FloatingActionButton(
                        heroTag: 'a',
                        onPressed: () {},
                        backgroundColor: Colors.white,
                        child: const Icon(
                          Icons.keyboard,
                          size: 34,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Container(
                        width: screenSize.width*0.3,
                        height: screenSize.height *0.1 -32,
                        decoration: ShapeDecoration(shadows: const [
                          BoxShadow(
                              color: Color.fromARGB(100, 75, 135, 232),
                              blurRadius: 10,
                              offset: Offset(0, 10)),
                        ], shape: StadiumBorder(), color: Colors.blue.shade800),
                        child: const Center(
                          child: Text(
                            'Pay Now',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height *0.1-16,
                      child: FloatingActionButton(
                        heroTag: 'b',
                        onPressed: () {},
                        backgroundColor: Colors.white,
                        child: const Icon(
                          Icons.money,
                          size: 34,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardInfo {
  Color? leftColor;
  Color? rightColor;

  String? userName;

  String? cardCategory;
  double? positionY = 0;
  double? rotate = 0;

  double? opacity = 0;
  double? scale = 0;

  CardInfo(
      {this.userName,
      this.cardCategory,
      this.opacity,
      this.positionY,
      this.rotate,
      this.scale,
      this.rightColor,
      this.leftColor});
}
