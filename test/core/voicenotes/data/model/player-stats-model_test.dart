import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/voicenotes/data/model/player-stats-model.dart';
import 'package:tatsam_app_experimental/core/voicenotes/domain/entity/player-stats.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/default-rating-scale-model.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const tPlayerStatsModel =
      PlayerStatsModel(totalLength: null, currentPosition: null);
  group('Model PlayerStatsModel', () {
    test('should be a extended version of PlayerStats', () async {
      expect(tPlayerStatsModel, isA<PlayerStats>());
    });

    // test('fromJson should transform raw-response into HubStatusModel',
    //     () async {
    //   //arrange
    //   final jsonMap =
    //       jsonDecode(fixtureReader(filename: 'player-stats-model.json')) as Map;
    //   //act
    //   final result = PlayerStatsModel.fromMap(jsonMap as Map<String, Duration>);
    //   //assert
    //   expect(result, tPlayerStatsModel);
    // });
  });
}
