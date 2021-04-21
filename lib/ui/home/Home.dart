import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Welcome To Routes Pay',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.w700,
          color: Colors.black54
        ),
        ),
      ),
    );
  }
}
