import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';

class DevRootView extends StatelessWidget {
  const DevRootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
                onPressed: () {
                  Get.toNamed(RouteName.devSettingsScreen);
                },
                child: const Text("Change BASE_URL")),
            OutlinedButton(
                onPressed: () {
                  Get.offAllNamed(RouteName.rootView);
                },
                child: const Text("Proceed"))
          ],
        ),
      ),
    );
  }
}
