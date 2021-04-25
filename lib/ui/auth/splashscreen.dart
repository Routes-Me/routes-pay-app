import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routes_pay/ui/auth/login.dart';
import 'package:routes_pay/ui/home/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 3;
  @override
  void initState() {
    super.initState();
    loadSplashScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration:BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              colors: [
                Colors.orange[600],
                Colors.orange[500],
                Colors.orange[400]
              ])
      ) ,
      child: Center(
        child: Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0),
                  bottomLeft: const Radius.circular(10.0),
                  bottomRight: const Radius.circular(10.0),
                )
            ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Routes Pay',
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w500
                    ),

                  ),
                ),
        )
      ),
    );
  }

  loadSplashScreen() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration,navigationPage);
  }
    void navigationPage() async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final isLogin = false;
      if((!isLogin)){
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Login()));

      }else{
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    }
}

