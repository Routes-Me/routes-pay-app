import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:routes_pay/ui/auth/login.dart';
import 'package:routes_pay/ui/viewmodel/login_viewmodel.dart';
import 'locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //setUpLocation();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(Routes());
  });
}

class Routes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: LoginViewModel()),
        ],
      child:MaterialApp(debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          "/login" : (context) => Login(),
        },
      )
    );
  }
}



