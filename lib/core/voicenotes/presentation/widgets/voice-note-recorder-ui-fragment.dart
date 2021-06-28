import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../asset-image-path/image-path.dart';
import '../../../responsive/scale-manager.dart';
import '../../../utils/color-pallete.dart';
import '../controller/voice-notes-controller.dart';

class VoiceNoteRecorder extends StatelessWidget {
  VoiceNoteRecorder({
    Key key,
  }) : super(key: key);

  final VoiceNoteController _voiceNoteController = Get.find();

  @override
  Widget build(BuildContext context) {
    final double textScale = ScaleManager.textScale.value;
    return Container(
      height: ScaleManager.spaceScale(
        spaceing: 50,
      ).value,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(171, 174, 178, 1),
          ),
        ),
      ),
      child: SizedBox(
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: ScaleManager.spaceScale(
                    spaceing: 26,
                  ).value,
                  child: SvgPicture.asset(
                    ImagePath.micImage,
                    color: blueDarkShade,
                    height: ScaleManager.spaceScale(
                      spaceing: 26,
                    ).value,
                  ),
                ),
                SizedBox(
                  width: ScaleManager.spaceScale(
                    spaceing: 12,
                  ).value,
                ),
                Obx(
                  () => Text(
                    // Elapsed Time String
                    "${_voiceNoteController.elapsedDuration.value.inMinutes<10?"0${_voiceNoteController.elapsedDuration.value.inMinutes}"
                        :"${_voiceNoteController.elapsedDuration.value.inMinutes}"}"
                        ":${_voiceNoteController.elapsedDuration.value.inSeconds-_voiceNoteController.elapsedDuration.value.inMinutes*60<10
                        ?"0${_voiceNoteController.elapsedDuration.value.inSeconds-_voiceNoteController.elapsedDuration.value.inMinutes*60}"
                        :"${_voiceNoteController.elapsedDuration.value.inSeconds-_voiceNoteController.elapsedDuration.value.inMinutes*60}"}",
                    style: GoogleFonts.zillaSlab(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      color: const Color.fromRGBO(171, 174, 178, 1),
                    ),
                    textScaleFactor: textScale,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    await _voiceNoteController.cancelOngoingRecording();
                  },
                  child: Text(
                    'CANCEL',
                    style: GoogleFonts.zillaSlab(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: blueDarkShade,
                    ),
                    textScaleFactor: textScale,
                  ),
                ),
                SizedBox(
                  width: ScaleManager.spaceScale(
                    spaceing: 21,
                  ).value,
                ),
                GestureDetector(
                  onTap: () async {
                    await _voiceNoteController.stopRecordingVoiceNote();
                  },
                  child: Container(
                      height: ScaleManager.spaceScale(
                        spaceing: 28,
                      ).value,
                      width: ScaleManager.spaceScale(
                        spaceing: 28,
                      ).value,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: blueDarkShade),
                      child: Icon(
                        Icons.done,
                        color: Colors.white,
                        size: ScaleManager.spaceScale(
                          spaceing: 20,
                        ).value,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
