import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

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
    AndroidNotification? androidNotification = notification?.android;

    String? imageUrl =
        androidNotification?.imageUrl ?? notification?.apple?.imageUrl;

    BigPictureStyleInformation? bigPicture;

    if (imageUrl != null && imageUrl.isNotEmpty) {
      final httpResponse = await http.get(Uri.parse(imageUrl));
      final bigPicturePath =
          await _saveImageToFile(httpResponse.bodyBytes, 'big_picture');
      final bigPictureFilePath = FilePathAndroidBitmap(bigPicturePath);

      bigPicture = BigPictureStyleInformation(
        bigPictureFilePath,
        contentTitle: notification?.title,
        summaryText: notification?.body,
      );
    }

    await _localNotification.show(
      notification.hashCode,
      notification?.title,
      notification?.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          "com.example.training_softdreams/android",
          "Training Soft Dreams Android Notification",
          channelDescription: "NgQuHuy",
          styleInformation: bigPicture,
          // <- gắn style có ảnh
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

  Future<String> _saveImageToFile(Uint8List bytes, String name) async {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/$name';
    final file = File(filePath);
    await file.writeAsBytes(bytes);
    return filePath;
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
