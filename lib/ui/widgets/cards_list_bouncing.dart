import 'package:flutter/material.dart';

class CardsListB extends StatefulWidget {
  const CardsListB({Key? key}) : super(key: key);

  @override
  _CardsListBState createState() => _CardsListBState();
}

class _CardsListBState extends State<CardsListB> {
  void getPostsData() {
    List<dynamic>? responseList;
    List<Widget> listItems = [];
    responseList!.forEach((post) {
      listItems.add(InkWell(
        onTap: () {
          if(post['id'] ==8) {
            print('object');

          }else if (post['id'] ==7){
            print('object');


          }
          else if (post['id'] ==9){
            print('object');

          }else{

          }
        },
        child: Container(
            height: 350,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
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
                        post["name"],
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
                        " ${post["count"].toString()}",
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
    getPostsData();
    controller.addListener(() {
      double value = controller.offset / 320;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[

          const SizedBox(
            height: 10,
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
                            heightFactor: 0.9,
                            alignment: Alignment.topCenter,
                            child: itemsData[index]),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
