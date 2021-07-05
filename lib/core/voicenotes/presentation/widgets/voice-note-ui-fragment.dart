import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-space.dart';
import 'package:tatsam_app_experimental/core/voicenotes/presentation/widgets/voice-note-note-player-ui-fragment.dart';
import 'package:tatsam_app_experimental/core/voicenotes/presentation/widgets/voice-note-recorder-ui-fragment.dart';

import '../controller/voice-notes-controller.dart';

class VoiceNoteFragment extends StatelessWidget {
  VoiceNoteFragment({
    Key? key,
  }) : super(key: key);

  final VoiceNoteController _voiceNoteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        switch (_voiceNoteController.playerState.value) {
          case VoiceNotePlayerUIState.IDLE:

            /// Technically this case needs not to be handled
            /// This would be handled from where it is being called
            return EmptySpacePlaceHolder();
          case VoiceNotePlayerUIState.RECORDING:
            return VoiceNoteRecorder();
          case VoiceNotePlayerUIState.RECORDED:
            return VoiceNotePlayer();
        }
      },
    );
  }
}
