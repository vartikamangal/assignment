import 'package:flutter/cupertino.dart';
import '../../../success/success-interface.dart';

class RecordingStopped extends Success {
  final String status;

  const RecordingStopped({
    required this.status,
  }) : super(
          message: 'Recording done',
        );
}
