import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/activity-scedule-guided-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/guided-activity-recommendation-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/path-information-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/activity-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/tag-model.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity-schedule-guided.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const List<ActivityScheduleGuidedModel> tActivitySceduleGuidedModel =
      <ActivityScheduleGuidedModel>[
  ];

  group('Model ActivityScheduleGuidedModel ', () {
    test('should be an extendor of ActivityScheduleGuidedModel', () async {
      //assert
      expect(tActivitySceduleGuidedModel.first, isA<ActivitySceduleGuided>());
    });
    test(
        'fromJson should transform raw-response into ActivityScheduleGuidedModel',
        () async {
      //arrange
      final jsonMap = jsonDecode(
              fixtureReader(filename: 'raw-activity-scedule-guided-model.json'))
          as List;
      //act
      final result = jsonMap
          .map((area) => ActivityScheduleGuidedModel.fromJson(
              area as Map<String, dynamic>))
          .toList();
      //assert
      expect(result, tActivitySceduleGuidedModel);
    });
  });
}
