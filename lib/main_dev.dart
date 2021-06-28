// Flutter imports:
import 'dart:developer';

import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:tatsam_app_experimental/core/secrets.dart';

// Project imports:
import 'core/session-manager/session-manager.dart';
import 'dependency_injection_container.dart';
import 'setup-my-app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await initializeDependencies();
  await SessionManager.persistDeviceId();
  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId(Secrets.ONESIGNAL_APPID);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    log("Accepted permission: $accepted");
  });
  OneSignal.shared.setNotificationWillShowInForegroundHandler(
      (OSNotificationReceivedEvent notification) {
    // Will be called whenever a notification is received in foreground
    // Display Notification, pass null param for not displaying the notification
    notification.complete(notification.notification);
  });
  setupApp();
}
