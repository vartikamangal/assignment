import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/utils/helper_functions/get-formatted-player-position-string.dart';
import 'package:tatsam_app_experimental/core/utils/helper_functions/player-position-calculator.dart';

import '../../../asset-image-path/image-path.dart';
import '../../../responsive/scale-manager.dart';
import '../../../utils/app-text-style-components/app-text-styles.dart';
import '../../../utils/color-pallete.dart';
import '../../../utils/universal-widgets/empty-space.dart';
import '../../data/model/player-stats-model.dart';
import '../../domain/entity/player-stats.dart';
import '../controller/voice-notes-controller.dart';

class VoiceNotePlayer extends StatelessWidget {
  VoiceNotePlayer({Key key}) : super(key: key);
  final VoiceNoteController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final double textScale = ScaleManager.textScale.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: ScaleManager.spaceScale(
            spaceing: 25,
          ).value,
        ),
        Row(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    _controller.playVoicenoteUI(
                      audioSource: _controller.currentVoiceNotePath.value,
                    );
                  },
                  child: SvgPicture.asset(
                    ImagePath.playButton,
                    height: ScaleManager.spaceScale(
                      spaceing: 22,
                    ).value,
                  ),
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
                  final PlayerStats duration =
                      snapshot.data as PlayerStatsModel;
                  return LinearProgressIndicator(
                    backgroundColor: greyLightShade,
                    value: calculatePosition(
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
                child:
                    /* Icon(Icons.cancel_rounded,
                color: blueDarkShade,
                size: ScaleManager.spaceScale(
                  spaceing: 30,
                ).value,)*/

                    SvgPicture.asset(
                  ImagePath.crossButton,
                  height: ScaleManager.spaceScale(
                    spaceing: 30,
                  ).value,
                )),
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
              return Text(
                getFormattedPlayerPosition(duration),
                style: AppTextStyle.verySmallGreyText.copyWith(fontSize: 12),
                textScaleFactor: textScale,
              );
            }
          },
        ),
      ],
    );
  }
}
