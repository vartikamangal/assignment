import 'package:flutter/cupertino.dart';
import '../../../success/success-interface.dart';

class RecordingStarted extends Success {
  final String recordingStatus;
  const RecordingStarted({
    required this.recordingStatus,
  }) : super(message: 'Recording started successfully');
}
