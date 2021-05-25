import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';

class RecordingStarted extends Success {
  final String recordingStatus;
  const RecordingStarted({
    @required this.recordingStatus,
  }) : super(message: 'Recording started successfully');
}
