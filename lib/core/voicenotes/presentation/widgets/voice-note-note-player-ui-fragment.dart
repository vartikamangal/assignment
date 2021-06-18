import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/utils/app-text-style-components/app-text-styles.dart';
import 'package:tatsam_app_experimental/core/utils/color-pallete.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-space.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/model/player-stats-model.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/entity/player-stats.dart';
import 'package:tatsam_app_experimental/core/voicenotes/presentation/controller/voice-notes-controller.dart';

class VoiceNotePlayer extends StatelessWidget {
  VoiceNotePlayer({Key key}) : super(key: key);
  final VoiceNoteController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height:  ScaleManager.spaceScale(
          spaceing: 25,
        ).value,),
        Row(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    _controller.playVoicenoteUI();
                  },
                  child:  SvgPicture.asset(ImagePath.playButton,
                  height:  ScaleManager.spaceScale(
                    spaceing: 22,
                  ).value,),
                ),

              ],
            ),
            SizedBox(
              width: ScaleManager.spaceScale(
                spaceing: 13,
              ).value,
            ),
            Expanded(
                child: StreamBuilder(
              stream: _controller.currentPlayingFileStats.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.none) {
                  /// Inactive progress bar
                  return LinearProgressIndicator(
                    backgroundColor: greyLightShade,
                    value: 0,
                  );
                } else {
                  /// active progress bar
                  final PlayerStats duration = snapshot.data as PlayerStatsModel;
                  return LinearProgressIndicator(
                    backgroundColor: greyLightShade,
                    value: _controller.calculatePosition(
                      duration.currentPosition,
                      duration.totalLength,
                    ),
                  );
                }
              },
            )),
            SizedBox(
              width: ScaleManager.spaceScale(
                spaceing: 20,
              ).value,
            ),
            GestureDetector(
              onTap: () async {
                await _controller.stopPlayerAndCleanPreviousRecording();
              },
              child:  Icon(Icons.cancel_rounded,
                color: blueDarkShade,
                size: ScaleManager.spaceScale(
                  spaceing: 30,
                ).value,),

              /*
               SvgPicture.asset(ImagePath.crossButton)*/
            ),
          ],
        ),
        StreamBuilder(
          stream: _controller.currentPlayingFileDuration,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.none) {
              return EmptySpacePlaceHolder();
            } else {
              final Duration duration = snapshot.data as Duration;
              return Text("${duration.inMinutes<10?"0${duration.inMinutes}":"${duration.inMinutes}"}"
                  ":${duration.inSeconds-duration.inMinutes*60<10?"0${duration.inSeconds-duration.inMinutes*60}":"${duration.inSeconds-duration.inMinutes*60}"}",
                style: AppTextStyle.verySmallGreyText.copyWith(
                    fontSize: 12
                ),);
            }
          },
        ),
      ],
    );
  }
}
