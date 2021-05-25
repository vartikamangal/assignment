import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'my-app.dart';

void setupApp() {
  /// Below line just for accessing reference
  // final apiKey = Flavor.I.getString(Keys.apiKey);
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('hi')],
      fallbackLocale: const Locale('en', 'US'),
      path: 'assets/translations',
      child: MyApp(),
    ),
  );
}
