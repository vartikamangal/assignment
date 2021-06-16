// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:tatsam_app_experimental/features/rapport-building/Presentation/controllers/rapport-building-controller.dart.dart';

String nameValidation({
  @required String value,
  @required RapportBuildingController controller,
}) {
  //print(controller.isWantToMoveFromNameScreen.value.toString());
  if (value.length==0 && controller.isWantToMoveFromNameScreen.value==true) {
    // print(controller.isWantToMoveFromNameScreen.value.toString());
    return 'Please enter name';
  }
  else if (!RegExp(r'^[a-zA-Z0-9]*$').hasMatch(value)) {
    controller.switchButtonStatus.value=false;
    return 'Special charecters & spaces not allowed';
  } else if (value.length >= 13) {
    controller.switchButtonStatus.value=false;
    return 'Name can not be too long';
  }
  else {
    controller.switchButtonStatus.value=true;
    return null;
  }
}
