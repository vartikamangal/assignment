// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flavor/flavor.dart';

class TestScreen extends StatelessWidget {
  final bannerColor = Flavor.I.color;
  final flavor = Flavor.I.environment;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bannerColor,
        title: Text(tr('title')),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.setLocale(const Locale('en', 'US'));
        },
        child: const Icon(Icons.translate),
      ),
      body: Center(
        child: Text(
          tr('welcome_text'),
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
