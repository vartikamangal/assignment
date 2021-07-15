import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/activity-status-model.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/entities/activity-status.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  final List<ActivityStatus> tActivityStatusModel = <ActivityStatus>[
    ActivityStatus(
        id: null,
        journeyId: 'journeyId',
        recommendationId: 'recommendationId',
        actionStatus: 'actionStatus',
        feedbackMood: 'feedbackMood',
        feedbackThoughts: 'feedbackThoughts')
  ];

  group('Model ActivityStatusModel ', () {
    test('should be an extendor of ActivityStatus', () async {
      //assert
      expect(tActivityStatusModel.first, isA<ActivityStatus>());
    });
    test('fromJson should transform raw-response into ActivityStatusModel',
        () async {
      //arrange
      final jsonMap =
          jsonDecode(fixtureReader(filename: 'raw-activity-status-model.json'))
              as List;
      //act
      final result = jsonMap
          .map((area) =>
              ActivityStatusModel.fromJson(area as Map<String, dynamic>))
          .toList();
      //assert
      expect(result, tActivityStatusModel);
    });
  });
}
