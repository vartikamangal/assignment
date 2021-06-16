// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

// Project imports:
import 'core/routes/app-routes/app-routes.dart';

class MyApp extends StatelessWidget {
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
