import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routes_pay/ui/auth/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Login()));
  });
}

