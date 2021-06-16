// Flutter imports:
import 'package:flutter/material.dart' hide Router;

// Project imports:
import '../../responsive/scale-manager.dart';

class ErrorScreenState extends StatelessWidget {
  final String errorMessage;

  const ErrorScreenState({Key key, this.errorMessage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return Container(
      child: Center(
        child: Row(
          children: [
            const Icon(
              Icons.cancel,
              color: Colors.red,
            ),
            SizedBox(
              width: ScaleManager.spaceScale(spaceing: 8).value,
            ),
            Text(
              "$errorMessage",
              textScaleFactor: textScaleFactor,
            ),
          ],
        ),
      ),
    );
  }
}
