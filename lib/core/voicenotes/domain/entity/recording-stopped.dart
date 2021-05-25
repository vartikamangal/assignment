import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';

class RecordingStopped extends Success {
  final String status;

  const RecordingStopped({
    @required this.status,
  }) : super(
          message: 'Recording done',
        );
}
