import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:routes_pay/ui/auth/login.dart';
import 'package:routes_pay/ui/auth/renewal_token.dart';
import 'package:routes_pay/ui/auth/signup.dart';
import 'package:routes_pay/ui/auth/splashscreen.dart';
import 'package:routes_pay/ui/home/Home.dart';
import 'package:routes_pay/ui/viewmodel/login_viewmodel.dart';
import 'package:routes_pay/ui/viewmodel/register_viewmodel.dart';

import 'locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocation();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: LoginViewModel()),
        ChangeNotifierProvider.value(value: RegisterViewModel()),
      ],
      child: Routes(),
    ));
  });
}

class Routes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        "/": (context) => SplashScreen(),
        "/login": (context) => Login(),
        "/signup": (context) => Signup(),
        "/home": (context) => Home(),
        "/renewal": (context) => RenewalToken(),
      },
    );
  }
}
