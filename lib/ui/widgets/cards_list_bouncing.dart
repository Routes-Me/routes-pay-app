import 'package:flutter/material.dart';

class CardsListB extends StatefulWidget {
  const CardsListB({Key? key}) : super(key: key);

  @override
  _CardsListBState createState() => _CardsListBState();
}

class _CardsListBState extends State<CardsListB> {
  void getCardsData() {
    double heightContainer = 420;
    List<dynamic> responseList = cards_info;
    List<Widget> listItems = [];
    responseList.forEach((card) {
      listItems.add(Column(
        children: [
          InkWell(
            onTap: () {
              if(card['id'] ==0) {
                setState(() {
                  heightContainer = 100;
                });
                print('object1');
              }else if (card['id'] ==1){
                print('object2');
              }
              else if (card['id'] ==2){
                print('object3');
              }else{

              }
            },
            child: AnimatedContainer(
                height: heightContainer,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withAlpha(100), blurRadius: 10.0),
                    ]),
                duration: Duration(milliseconds: 500),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            card["name"],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat-Arabic Regular'),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            " ${card["count"].toString()}",
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
          ),
          //SizedBox(height: 400,)
        ],
      ));
    });
    setState(() {
      itemsData = listItems;
    });
  }
  ScrollController controller = ScrollController();

  bool closeTopContainer = false;

  double topContainer = 0;

  List<Widget> itemsData = [];
  @override
  void initState() {
    super.initState();
    getCardsData();
    controller.addListener(() {
      double value = controller.offset / 119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[

            const SizedBox(
              height: 50,
            ),
            Expanded(
                child: ListView.builder(
                    controller: controller,
                    itemCount: itemsData.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      double scale = 1.0;
                      if (topContainer > 0.5) {
                        scale = index + 0.5 - topContainer;
                        if (scale < 0) {
                          scale = 0;
                        } else if (scale > 1) {
                          scale = 1;
                        }
                      }
                      return Opacity(
                        opacity: scale,
                        child: Transform(
                          transform: Matrix4.identity()..scale(scale, scale),
                          alignment: Alignment.bottomCenter,
                          child: Align(
                              heightFactor:0.5,
                              alignment: Alignment.topCenter,
                              child: itemsData[index]),
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
const cards_info = [
  {
    'id': 0,
    "name": "Card Name 1",
    "brand": "Hawkers",
    "count": 25,
    "image": "ahkam1.png",
  },
  {
    'id': 1,
    "name": "Card Name 2",
    "brand": "Hawkers",
    "count": 25,
    "image": "ahkam1.png",
  },
  {
    'id': 2,
    "name": "Card Name 3",
    "brand": "Hawkers",
    "count": 25,
    "image": "ahkam1.png",
  },
  {
    'id': 2,
    "name": "Card Name 3",
    "brand": "Hawkers",
    "count": 25,
    "image": "ahkam1.png",
  },




];
