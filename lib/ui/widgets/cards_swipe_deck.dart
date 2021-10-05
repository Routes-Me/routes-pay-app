import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:routes_pay/ui/viewmodel/cards_model.dart';
import 'package:routes_pay/ui/widgets/cards_slider.dart';
import 'package:swipe_deck/swipe_deck.dart';

class CardsSwipeDeck extends StatefulWidget {
  const CardsSwipeDeck({Key? key}) : super(key: key);

  @override
  _CardsSwipeDeckState createState() => _CardsSwipeDeckState();
}

class _CardsSwipeDeckState extends State<CardsSwipeDeck> {
  var cardInfoList = [
  CardInfo(
  userName: "KHALED SALEH",
  rightColor: Color.fromARGB(255, 85, 137, 234),
  leftColor: Color.fromARGB(215, 45, 137, 214),
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
  rightColor: Color.fromARGB(255, 33, 51, 111),
  leftColor: Color.fromARGB(255, 22, 51, 75),
  ),

  ];
  final borderRadius = BorderRadius.circular(20.0);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SwipeDeck(
        startIndex: 2,
        aspectRatio: 4 / 2.4,
        emptyIndicator: Container(child: Center(child: Text("Nothing Here"),),),
        widgets: cardInfoList
            .map((cardInfo) => GestureDetector(
          onTap: () {
            print(cardInfo.userName);
          },
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
            child: Stack(
              children: [
                //number
                const Positioned(
                  top: 20,
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
                  top: 50,
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
                    left: 4,
                    bottom: 4,
                    child: Center(
                      child: Consumer<CardsModel>(
                        builder: (context,data,_)=> Container(
                          height:Get.height >620? Get.height * 0.3:Get.height * 0.3,
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
                      ),
                    ))
              ],
            ),
          )
        ))
            .toList(),
      ),
    );
  }
}
