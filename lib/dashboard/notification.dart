import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotoficationsServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSettings =
      AndroidInitializationSettings('logo');

  void initialiseNotification() async {
    InitializationSettings initializationSettings =
        InitializationSettings(android: _androidInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    print('Initialisation Complete');
  }

  void sendNotification() async {
    print('Pressed button to Send Notification');
    AndroidNotificationDetails _androidNotificationDetails =
        AndroidNotificationDetails('channelID', 'channelName',
            playSound: true,
            priority: Priority.max,
            importance: Importance.max);
    NotificationDetails notificationDetails =
        NotificationDetails(android: _androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(0, 'Chop-Chop Delivery Partner',
        'New Orders Arrived', notificationDetails);
  }
}
