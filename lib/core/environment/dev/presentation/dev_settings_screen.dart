import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/environment/env-based-view.dart';
import 'package:tatsam_app_experimental/core/session-manager/base-url-controller.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-space.dart';

class DevSettingsScreen extends StatelessWidget {
  DevSettingsScreen({Key? key}) : super(key: key);
  final BaseUrlController _baseUrlController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dev Settings"),
      ),
      body: ListView(
        children: [
          EnvironmentBasedView(
            dev: ListTile(
              leading: const Icon(Icons.link),
              onTap: () {
                Get.bottomSheet(Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          hintText: "Enter New URL here",
                          prefixIcon: Icon(Icons.link),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (url) {
                          _baseUrlController.changeBaseUrl(url: url);
                        },
                      ),
                    ],
                  ),
                ));
              },
              title: const Text('Change Base Url'),
              subtitle:
                  Obx(() => Text("Current: ${_baseUrlController.baseUrl}")),
              trailing: const Icon(Icons.navigate_next),
            ),
            prod: EmptySpacePlaceHolder(),
            staging: EmptySpacePlaceHolder(),
          ),
        ],
      ),
    );
  }
}
