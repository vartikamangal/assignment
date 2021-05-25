import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/session-manager/session-manager.dart';
import 'dependency_injection_container.dart';
import 'setup-my-app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await initializeDependencies();
  await SessionManager.persistDeviceId();
  setupApp();
}
