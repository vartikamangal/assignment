import 'package:flutter/material.dart';

class UiForOldAndNewUserRenderer extends StatelessWidget {
  final bool isNewUser;
  final Widget widgetForNewUser;
  final Widget widgetForOldUser;

  const UiForOldAndNewUserRenderer({
    Key? key,
    required this.isNewUser,
    required this.widgetForNewUser,
    required this.widgetForOldUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isNewUser) {
      return widgetForNewUser;
    } else {
      return widgetForOldUser;
    }
  }
}
