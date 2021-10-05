
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:routes_pay/services/notifications.dart';
import 'package:routes_pay/ui/auth/login.dart';
import 'package:routes_pay/ui/auth/other_options_for_login.dart';
import 'package:routes_pay/ui/auth/renewal_token.dart';
import 'package:routes_pay/ui/auth/signup.dart';
import 'package:routes_pay/ui/auth/splashscreen.dart';
import 'package:routes_pay/ui/home/home.dart';
import 'package:routes_pay/controller/cards_controller.dart';
import 'package:routes_pay/ui/viewmodel/login_viewmodel.dart';
import 'package:routes_pay/ui/viewmodel/register_viewmodel.dart';
import 'package:routes_pay/controller/social_login_controller.dart';

import 'locator.dart';

///on background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print(message.data);
}
//request permitions
requestPermssion()async{
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}

/// initial message from terminate
Future<void> initialMessage() async {
   await FirebaseMessaging.instance.getInitialMessage().then((message) {
    if(message !=null){
      print('init message Ok ,terminate');

    }
  });


}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);



  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  //Notifications


  setUpLocation();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: LoginViewModel()),
        ChangeNotifierProvider.value(value: RegisterViewModel()),
        ChangeNotifierProvider.value(value: SocialLoginController()),
        ChangeNotifierProvider.value(value: CardsModel()),

      ],
      child: Routes(),
    ));
  });
}

class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocalNotificationService.initialize(context);

    initialMessage();
    requestPermssion();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.notification!.body);
      LocalNotificationService.display(message);
    });

    ///on open app but in background NOT TERMINATE
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      final routeFromMessage = message.data['route'];
      print('route from message $routeFromMessage');
      print(routeFromMessage);
      if (notification != null && android != null) {
        print('message onOpen Ok');
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          primarySwatch: Colors.blue,
          fontFamily: 'Montserrat-Arabic Regular',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                  fontFamily: 'Montserrat-Arabic Regular',
                  fontSize: 44,
                  color: Colors.white),
              headline5: const TextStyle(
                  fontFamily: 'Montserrat-Arabic Regular',
                  fontSize: 16,
                  color: Colors.black),
              headline4: const TextStyle(
                  fontFamily: 'Montserrat-Arabic Regular',
                  fontSize: 15,
                  wordSpacing: 1,
                  letterSpacing: 1,
                  height: 1.4,
                  color: Colors.white),
              headline3: TextStyle(
                fontFamily: 'Montserrat-Arabic Regular',
                fontSize: 12,
                color: Colors.black.withOpacity(0.8),
              ))),
      initialRoute: '/',
      routes: {
        "/": (context) => Home(),
        "/login": (context) => Login(),
        "/signup": (context) => Signup(),
        "/home": (context) => Home(),
        "/renewal": (context) => RenewalToken(),
        "/login-with-social": (context) => LoginWithSocial(),
      },
    );
  }
}
