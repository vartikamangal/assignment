// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/analytics/analytics-setup.dart';

// Project imports:
import 'core/routes/app-routes/app-routes.dart';

class MyApp extends StatefulWidget {
  final SetupAnalytics analyticsService;

  const MyApp({
    Key key,
    @required this.analyticsService,
  }) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    setupInitialiBindings();
    super.initState();
  }

  Future<void> setupInitialiBindings() async {
    await widget.analyticsService.initializeAndStartRecording();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.fadeIn,
      debugShowCheckedModeBanner: false,
      initialRoute: RouteName.rootView,
      onGenerateRoute: GenerateRoute.generateRoute,
      localizationsDelegates: context.localizationDelegates,
      theme: ThemeData(
        canvasColor: Colors.white,
      ),
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
