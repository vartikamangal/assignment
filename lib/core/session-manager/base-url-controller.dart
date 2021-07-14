import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/extensions/url-maker.dart';

class BaseUrlController extends GetxController {
  RxString baseUrl = RxString(BASE_URL);

  void changeBaseUrl({required String url}) {
    baseUrl.value = url;
  }
}
