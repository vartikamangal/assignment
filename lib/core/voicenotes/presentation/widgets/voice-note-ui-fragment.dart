import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/voice-notes-controller.dart';
import 'voice-note-note-player-ui-fragment.dart';
import 'voice-note-recorder-ui-fragment.dart';

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
