// ignore: constant_identifier_names
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/session-manager/base-url-controller.dart';

const BASE_URL = "https://api.dev.tatsam.in";

extension MakeUrl on String {
  String makeUrl() => "${Get.find<BaseUrlController>().baseUrl.value}$this";
}
