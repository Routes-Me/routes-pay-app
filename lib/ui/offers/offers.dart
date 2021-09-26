import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:routes_pay/ui/widgets/common_widgets.dart';

class Offers extends StatefulWidget {
  const Offers({Key? key}) : super(key: key);

  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  final double _borderRadius = 24;

  var items = [
    OfferInfo('Kuwait Buses', const Color(0xff6DC8F3), Color(0xff73A1F9),
        4.4, 'Kuwait', 'Pay 8 kd and get 10'),
    OfferInfo('Kuwait Buses', Color(0xffFFB157), const Color(0xffFFA057), 3.7,
        'Kuwait', 'Pay 8 kd and get 10'),
    OfferInfo('Kuwait Buses', const Color(0xffFF5B95), const Color(0xffF8556D), 4.5,
        'Kuwait', 'Pay 8 kd and get 10'),
    OfferInfo('Kuwait Buses', const Color(0xffD76EF5), Color(0xff8F7AFE), 4.1,
        'Kuwait', 'Pay 8 kd and get 10'),
    OfferInfo('Kuwait Buses BBBB', Color(0xff42E695), const Color(0xff3BB2B8), 4.2,
        'Kuwait', 'Pay 8 kd and get 10'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade500,
        centerTitle: true,
        title: Text('Offers',style: TextStyle(
          fontFamily: 'Avenir'
        ),),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_borderRadius),
                      gradient: LinearGradient(colors: [
                        items[index].startColor,
                        items[index].endColor
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                          color: items[index].endColor,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: CustomPaint(
                      size: Size(100, 150),
                      painter: CustomCardShapePainter(_borderRadius,
                          items[index].startColor, items[index].endColor),
                    ),
                  ),
                  Positioned.fill(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Image.asset(
                            'assets/images/bus_icon.png',
                            height: 64,
                            width: 64,
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                items[index].name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Avenir',
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                items[index].category,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Avenir',
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Flexible(
                                    child: Text(
                                      items[index].location,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Avenir',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                items[index].rating.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Avenir',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              RatingBar(rating: items[index].rating),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
class OfferInfo {
  final String name;
  final String category;
  final String location;
  final double rating;
  final Color startColor;
  final Color endColor;

  OfferInfo(this.name, this.startColor, this.endColor, this.rating,
      this.location, this.category);
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}