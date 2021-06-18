// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:tatsam_app_experimental/core/analytics/analytics-setup.dart';
import 'package:tatsam_app_experimental/dependency_manager/core_dependency_managers.dart';

// Project imports:
import 'my-app.dart';

void setupApp() {
  /// Below line just for accessing reference
  // final apiKey = Flavor.I.getString(Keys.apiKey);
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('hi')],
      fallbackLocale: const Locale('en', 'US'),
      path: 'assets/translations',
      child: MyApp(
        analyticsService: sl_core_dependencies<SetupAnalytics>(),
      ),
    ),
  );
}
