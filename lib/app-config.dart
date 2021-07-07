import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/env.dart';

class AppConfig extends InheritedWidget {
  const AppConfig({
    required this.appTitle,
    required this.secrets,
    required this.env,
    required Widget child,
  }) : super(child: child);

  final String appTitle;
  final TestSecrets secrets;
  final Env env;

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(aspect: AppConfig)!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

class TestSecrets {
  final String secretKey;

  const TestSecrets({required this.secretKey});
}
