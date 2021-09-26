import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServiceD {
    AndroidNotificationChannel channel =  const AndroidNotificationChannel(
      'high_important_channel', //'id'
      'High Important Notification', //title
      'description', //desc
      importance: Importance.high,
      playSound: true);
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Future<void>  messagingHandler ()async {
    await Firebase.initializeApp();

  }

    Future<void> firebaseMessagingHandler(RemoteMessage message) async {
      await Firebase.initializeApp();
    }
}

