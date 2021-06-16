import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/root-controller.dart';

class RootView extends GetWidget<RootController> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
