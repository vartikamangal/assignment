import 'package:flutter/material.dart';
import 'package:tatsam_app_experimental/app-config.dart';

class EnvironmentBasedView extends StatelessWidget {
  const EnvironmentBasedView({
    Key? key,
    required this.dev,
    required this.prod,
    required this.staging,
  }) : super(key: key);
  final Widget dev;
  final Widget prod;
  final Widget staging;
  @override
  Widget build(BuildContext context) {
    final env = AppConfig.of(context).env;
    return env.map(
      prod: (_) => prod,
      staging: (_) => staging,
      dev: (_) => dev,
    );
  }
}
