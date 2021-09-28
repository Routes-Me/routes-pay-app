import 'dart:async';
import 'package:get/get.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routes_pay/ui/auth/login.dart';
import 'package:routes_pay/ui/home/home.dart';
import 'package:routes_pay/ui/viewmodel/social_login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 3;
  bool done = false;

  @override
  void initState() {
    super.initState();
    //loadSplashScreen();
    Future.delayed(const Duration(milliseconds: 2600), () {
      setState(() {
        done =true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {


    return done
        ? Consumer<SocialLoginController>(
            builder: (context, provider, _) => provider.signedIn
                ? Home()
                :Login() )
        : Container(
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
          );
  }

  loadSplashScreen() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    var statusLogin = Provider.of<SocialLoginController>(context,listen: false).signedIn;
      if(statusLogin){
        Get.off(()=>Home());
      }else{
        Get.to(()=>Login());
      }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    final type = (preferences.getInt('type_of_last_login') != null)
        ? preferences.getInt('type_of_last_login')
        : null;
    print('Type $type');

    (preferences.getBool('isLogin') == null)
        ? false
        : preferences.getBool('isLogin');
  }
}
