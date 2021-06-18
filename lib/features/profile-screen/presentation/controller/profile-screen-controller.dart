// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/session-manager/session-manager.dart';

// Project imports:

class ProfileScreenController extends GetxController{
  RxInt selectedScreenIndex=0.obs;
  Rx<Widget> currentSelectedPage = Rx<Widget>();
  RxString userName = RxString('');

  Future<void> selectScreen(int index) async {
    selectedScreenIndex.value = index;
  }

  Future<void> setup() async{
    userName.value = await SessionManager.getPersistedUsername();
  }
}
