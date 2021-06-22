// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-tracking-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-id-model.dart';
import '../../../../fixtures/fixture-reader.dart';

void main() {
  final tFeelingModel = MoodTrackingModel(
    subjectId: const SubjectIdModel(id: '74a439b1-396b-43c2-a859-608c055a78a3'),
    id: 3,
    moodDuration: 'SEVEN_DAYS',
    activityType: 'ONBOARDING',
    mood: 'NEUTRAL',
    createdWhen: DateTime.parse('2021-06-03T13:35:37.191Z'),
  );
  group('MODEL MoodTrackingModel ', () {
    test('should be an extendor of MoodTracking', () async {
      //assert
      expect(tFeelingModel, isA<MoodTrackingModel>());
    });
    test('fromJson() should return MoodTracking', () async {
      //arrange
      final jsonMap =
          jsonDecode(fixtureReader(filename: 'set-feeling-body-raw.json'));
      //act
      final result =
          MoodTrackingModel.fromJson(jsonMap as Map<String, dynamic>);

      //assert
      expect(result, tFeelingModel);
    });
    test('toJson should change the FeelingModel into a proper Map', () async {
      //arrange
      final expectedJson = {
        "subjectId": {"id": "74a439b1-396b-43c2-a859-608c055a78a3"},
        "id": 3,
        "activityType": "ONBOARDING",
        "moodDuration": "SEVEN_DAYS",
        "mood": "NEUTRAL"
      };
      //act
      final result = tFeelingModel.toJson();
      //assert
      expect(result, expectedJson);
    });
  });
}
