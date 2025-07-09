import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage remoteMessage) async {
  await NotificationService.instance.setupNotification();
  await NotificationService.instance.showNotification(remoteMessage);
}

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotification = FlutterLocalNotificationsPlugin();
  bool _isLocalNotificationInitialized = false;

  Future<void> initialize() async {
    await _requestPermission();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await setupNotification();
    await _setupMessageHandler();
    print(await _firebaseMessaging.getToken());
  }

  Future<void> _requestPermission() async {
    await _firebaseMessaging.requestPermission();
  }

  Future<void> setupNotification() async {
    if (_isLocalNotificationInitialized) return;
    const channel = AndroidNotificationChannel(
      "com.example.training_softdreams/android",
      "Training Soft Dreams Android Notification",
      description: "NgQuHuy",
      importance: Importance.high,
    );
    await _localNotification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    const initializationSettingAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    final initializationSettingDarwin = DarwinInitializationSettings();

    final initializationSettings = InitializationSettings(
      android: initializationSettingAndroid,
      iOS: initializationSettingDarwin,
    );

    await _localNotification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (notificationResponse) {
        print("Foreground notification is clicked - NgQuHuy");
      },
    );

    _isLocalNotificationInitialized = true;
  }

  Future<void> showNotification(RemoteMessage remoteMessage) async {
    RemoteNotification? notification = remoteMessage.notification;
    AndroidNotification? androidNotification =
        remoteMessage.notification?.android;
    if (notification != null && androidNotification != null) {
      await _localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            "com.example.training_softdreams/android",
            "Training Soft Dreams Android Notification",
            channelDescription: "NgQuHuy",
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: remoteMessage.data.toString(),
      );
    }
  }

  Future<void> _setupMessageHandler() async {
    FirebaseMessaging.onMessage.listen((remoteMessage) {
      showNotification(remoteMessage);
    });
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundNotification);
  }

  void _handleBackgroundNotification(RemoteMessage remoteMessage) {
    print(remoteMessage.data['type']);
  }
}
