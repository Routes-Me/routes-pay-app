import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:routes_pay/ui/auth/login.dart';
import 'package:routes_pay/ui/auth/other_options_for_login.dart';
import 'package:routes_pay/ui/auth/renewal_token.dart';
import 'package:routes_pay/ui/auth/signup.dart';
import 'package:routes_pay/ui/auth/splashscreen.dart';
import 'package:routes_pay/ui/home/home.dart';
import 'package:routes_pay/ui/viewmodel/cards_model.dart';
import 'package:routes_pay/ui/viewmodel/login_viewmodel.dart';
import 'package:routes_pay/ui/viewmodel/register_viewmodel.dart';
import 'package:routes_pay/ui/viewmodel/social_login_controller.dart';

import 'locator.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print(message.data);
  flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
        ),iOS: IOSNotificationDetails(),
      ),);
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

//initial message
Future<void> initialMessage() async {
  var message = await FirebaseMessaging.instance.getInitialMessage();

  if(message != null){
    print('init message Ok');
  }

}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

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
    initialMessage();
    requestPermssion();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.notification!.body);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',

              ),iOS: IOSNotificationDetails()
            ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        print('message onOpen Ok');
      }
    });

  }
  //send a message
  void showNotification()async {
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing ",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name, channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
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
        "/": (context) => SplashScreen(),
        "/login": (context) => Login(),
        "/signup": (context) => Signup(),
        "/home": (context) => Home(),
        "/renewal": (context) => RenewalToken(),
        "/login-with-social": (context) => LoginWithSocial(),
      },
    );
  }
}
