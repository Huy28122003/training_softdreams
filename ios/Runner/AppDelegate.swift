import Flutter
import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications   

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    FirebaseApp.configure()

    UNUserNotificationCenter.current().delegate = self   
    application.registerForRemoteNotifications()        

    Messaging.messaging().delegate = self

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
