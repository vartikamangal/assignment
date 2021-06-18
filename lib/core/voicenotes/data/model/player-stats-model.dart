import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/entity/player-stats.dart';

class PlayerStatsModel extends PlayerStats {
  const PlayerStatsModel({
    @required Duration totalLength,
    @required Duration currentPosition,
  }) : super(
          totalLength: totalLength,
          currentPosition: currentPosition,
        );

  factory PlayerStatsModel.fromMap(Map<String, Duration> map) {
    return PlayerStatsModel(
      totalLength: map['duration'],
      currentPosition: map['progress'],
    );
  }
}
