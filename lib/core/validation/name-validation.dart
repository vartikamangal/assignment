import 'package:flutter/foundation.dart';

String nameValidation({
  @required String value,
}) {
  if (!RegExp(r'^[a-zA-Z0-9]*$').hasMatch(value)) {
    return 'Special charecters & spaces not allowed';
  } else if (value.length >= 13) {
    return 'Name can not be too long';
  } else {
    return null;
  }
}
