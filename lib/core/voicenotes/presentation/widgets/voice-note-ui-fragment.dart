import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/voicenotes/presentation/controller/voice-notes-controller.dart';
import 'package:tatsam_app_experimental/core/voicenotes/presentation/widgets/voice-note-note-player-ui-fragment.dart';
import 'package:tatsam_app_experimental/core/voicenotes/presentation/widgets/voice-note-recorder-ui-fragment.dart';

class VoiceNoteFragment extends StatelessWidget {
  VoiceNoteFragment({
    Key key,
  }) : super(key: key);

  final VoiceNoteController _voiceNoteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (_voiceNoteController.isPlayableFilePresent()) {
          return VoiceNotePlayer();
        } else {
          return VoiceNoteRecorder();
        }
      },
    );
  }
}
