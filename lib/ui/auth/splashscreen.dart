import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routes_pay/ui/auth/login.dart';
import 'package:routes_pay/ui/home/home.dart';
import 'package:routes_pay/controller/social_login_controller.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool done = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2800), () {
      setState(() {
        done = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SocialLoginController>(context);
    return done
        ? FutureBuilder(
        future: provider.tryLogin(),
        builder: (context, data) => provider.signedIn ? Home():
            Login())
        : Scaffold(
            body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      colors: [
                    Colors.orange.shade700,
                    Colors.orange.shade500,
                    Colors.orange.shade300
                  ])),
              child: Center(
                  child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    )),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Routes Pay',
                    style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )),
            ),
          );
  }

}
