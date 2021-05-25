import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/routes/app-routes/app-routes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.fadeIn,
      debugShowCheckedModeBanner: false,
      initialRoute: RouteName.origin,
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
