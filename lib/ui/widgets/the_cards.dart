import 'package:flutter/material.dart';

class TheCards extends StatefulWidget {
  const TheCards({Key? key}) : super(key: key);

  @override
  _TheCardsState createState() => _TheCardsState();
}

class _TheCardsState extends State<TheCards> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Container(
                  color: Colors.deepOrange,
                  width: 300,
                  height: 650,
                ),
              ),
            ]
          )
        ],
      ),
    );
  }
}
