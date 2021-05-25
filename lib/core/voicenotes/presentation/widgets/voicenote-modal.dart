import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/voicenotes/presentation/controller/voice-notes-controller.dart';

class VoiceNoteModal extends StatelessWidget {
  final VoiceNoteController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Notes Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 2,
        ),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          children: [
            _TestCard(
              title: 'Play Recording',
              subTitle: 'Will play recording, if everything goes fine.',
              onTap: () {},
              cardColor: Colors.amber,
              titleColor: Colors.black,
              textColor: Colors.grey[900],
            ),
            Obx(
              () => _TestCard(
                title: _controller.isRecording.value
                    ? 'Recording...'
                    : 'Start Recording',
                subTitle: _controller.isRecording.value
                    ? 'Recording your voice note, Keep telling your feelings.'
                    : 'Will start recording, if everyting goes fine.',
                onTap: _controller.isRecording.value
                    // This check-flag was inside the data-layer, but don't seem to work coz. of unknown reasons.
                    // That's why placing here
                    ? () async {
                        //! If already recodring, do nothing
                      }
                    : () async {
                        //* else record
                        await _controller.recordVoiceNote();
                      },
                cardColor: _controller.isRecording.value
                    ? Colors.green
                    : Colors.blueAccent,
                titleColor: Theme.of(context).canvasColor,
                textColor: Theme.of(context).canvasColor,
              ),
            ),
            Obx(
              () => _TestCard(
                title: 'Stop Recording',
                subTitle: 'Will stop recording, if everything goes fine.',
                onTap: () async {
                  await _controller.stopRecordingVoiceNote();
                },
                cardColor: _controller.isRecording.value
                    ? Colors.redAccent
                    : Colors.white,
                titleColor: _controller.isRecording.value
                    ? Theme.of(context).canvasColor
                    : Colors.black,
                textColor: _controller.isRecording.value
                    ? Theme.of(context).canvasColor
                    : Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TestCard extends StatelessWidget {
  const _TestCard({
    Key key,
    @required this.onTap,
    @required this.subTitle,
    @required this.title,
    @required this.cardColor,
    @required this.textColor,
    @required this.titleColor,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final Callback onTap;
  final Color cardColor;
  final Color textColor;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textScaleFactor: ScaleManager.textScale.value,
                style: GoogleFonts.poppins(
                  color: titleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: ScaleManager.spaceScale(
                    spaceing: 22,
                  ).value,
                ),
              ),
              SizedBox(
                height: ScaleManager.spaceScale(
                  spaceing: 2,
                ).value,
              ),
              Text(
                subTitle,
                textScaleFactor: ScaleManager.textScale.value,
                style: GoogleFonts.poppins(
                  color: textColor,
                  fontSize: ScaleManager.spaceScale(
                    spaceing: 14,
                  ).value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
