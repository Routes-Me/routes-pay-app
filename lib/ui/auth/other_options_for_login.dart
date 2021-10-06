import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:routes_pay/controller/social_login_controller.dart';

class LoginWithSocial extends StatefulWidget {
  static const routeName = "/login-with-social";

  const LoginWithSocial({Key? key}) : super(key: key);

  @override
  _LoginWithSocialState createState() => _LoginWithSocialState();
}

class _LoginWithSocialState extends State<LoginWithSocial> {
  @override
  Widget build(BuildContext context) {
    final sizeOfScreen = MediaQuery.of(context);
    final providerLogin = Provider.of<SocialLoginController>(context);
    return Scaffold(
      appBar: AppBar(title: Text('SignIn With Social', style: Theme
          .of(context)
          .textTheme
          .headline4,),
        centerTitle: true,
        backgroundColor: Colors.orange[500],
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40,),
              buildLogInButton(
                  'Google', Colors.blue.shade900, sizeOfScreen, Colors.red,
                  FontAwesomeIcons.google, () {
                Provider.of<SocialLoginController>(context, listen: false)
                    .loginWithGoogle(context)
                    .then((value) async {
                  if (providerLogin.isSigningInGoogle) {
                    Navigator.of(context).popAndPushNamed('/home');
                  } else {
                    print('false');
                  }
                });
              }),
              buildLogInButton('FaceBook', Colors.blue.shade900, sizeOfScreen,
                  Colors.blue.shade900, FontAwesomeIcons.facebook, () {
                    Provider.of<SocialLoginController>(context, listen: false)
                        .loginWithFacebook()
                        .then((value) {
                      if (providerLogin.facebookIsLogin!) {
                        Navigator.of(context).popAndPushNamed('/home');
                      } else {
                        print('false');
                      }
                    });


                  }),
              buildLogInButton(
                  'Apple', Colors.black, sizeOfScreen, Colors.black,
                  FontAwesomeIcons.apple, () async {
                 if(Platform.isIOS){
                   try {
                     Provider.of<SocialLoginController>(context, listen: false).signInWithApple().then((value) {
                       if (providerLogin.signedIn) {
                         Navigator.of(context).popAndPushNamed('/home');
                       } else {
                         print('false');
                       }
                     });
                   } catch (e) {
                     // TODO: Show alert here
                     print(e);
                   }
                 }

              }),
              const SizedBox(height: 90,),
              SpinKitCubeGrid(
                color: Colors.blue.shade900,
                size: 58.0,
                duration: const Duration(seconds: 3),

              ),

              SizedBox(height: sizeOfScreen.size.height - 200,)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLogInButton(String title, Color textColor, MediaQueryData size,
      Color iconColor, IconData icon, function) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: function,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 32, color: iconColor,),
                const SizedBox(width: 10,),
                Text(title, style: TextStyle(
                    color: textColor,
                    fontFamily: 'Montserrat-Arabic Regular',
                    fontSize: 22
                ),)
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: size.size.width,
            height: 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.withOpacity(0.5)),
          ),
        ),

      ],
    );
  }
}
