// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:

void setupApp(Widget child) {
  /// Below line just for accessing reference
  // final apiKey = Flavor.I.getString(Keys.apiKey);
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('hi')],
      fallbackLocale: const Locale('en', 'US'),
      path: 'assets/translations',
      child: child,
    ),
  );
}
