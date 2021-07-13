import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity-status.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/activity-status-model.dart';
import '../../../../fixtures/fixture-reader.dart';

void main() {
  const List<ActivityStatus> tActivityStatus = <ActivityStatusModel>[
    ActivityStatusModel(
      id: 19351,
      journeyId: "1b942ecc-7c76-4237-8f8b-216b9c22e900",
      recommendationId: null,
      actionStatus: "COMPLETED",
      feedbackMood: "NEUTRAL",
      feedbackThoughts: "",
    )
  ];

  group('Model ActivityStatusModel ', () {
    test('should be an extendor of ActivityStatusModel', () async {
      //assert
      expect(tActivityStatus.first, isA<ActivityStatus>());
    });
    test('fromJson should transform raw-response into ActivityStatusModel',
        () async {
      //arrange
      final jsonMap =
          jsonDecode(fixtureReader(filename: 'activity-status.json')) as List;
      //act
      final result = jsonMap
          .map((area) =>
              ActivityStatusModel.fromJson(area as Map<String, dynamic>))
          .toList();
      //assert
      expect(result, tActivityStatus);
    });
    // test('toJson should transform the model into a Map again', () async {
    //   //arrange
    //   final expectedJson =
    //   jsonDecode(fixtureReader(filename: 'activity-status.json'))
    //   as List;
    //   //act
    //   final result = tActivityStatus
    //       .map((area) => (area as ActivityStatusModel).toJson())
    //       .toList();
    //   //assert
    //   expect(result, expectedJson);
    // });
  });
}
