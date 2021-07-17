import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/activity-status-model.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/entities/activity-status.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  final tActivityStatus = ActivityStatus(
      id: 1,
      journeyId: 'journeyId',
      recommendationId: 'recommendationId',
      actionStatus: 'actionStatus',
      feedbackMood: 'feedbackMood',
      feedbackThoughts: 'feedbackThoughts');

  final tActivityStatusModel = ActivityStatusModel.fromDomain(ActivityStatus(
      id: 1,
      journeyId: 'journeyId',
      recommendationId: 'recommendationId',
      actionStatus: 'actionStatus',
      feedbackMood: 'feedbackMood',
      feedbackThoughts: 'feedbackThoughts'));

  test('from domain to take entity and covert in ActivityStatusModel',
      () async {
    //act
    final result = ActivityStatusModel.fromDomain(tActivityStatus);
    //expect
    expect(result, isA<ActivityStatusModel>());
  });

  test('from json should return valid ActivityStatusModel', () async {
    //arrange
    final jsonMap =
        jsonDecode(fixtureReader(filename: 'activity-status-model.json'))
            as List<dynamic>;
    //act
    final result =
        ActivityStatusModel.fromJson(jsonMap.first as Map<String, dynamic>);

    //expect
    expect(result.toString(), tActivityStatusModel.toString());
  });

  test(
      'To json of ActivityStatusModel should return a json ActivityStatusModel',
      () async {
    //arrange
    final jsonMap =
        jsonDecode(fixtureReader(filename: 'activity-status-model.json'))
            as List;
    //act
    final j = tActivityStatusModel.toJson();
    //expect
    expect(jsonMap.first, j);
  });
  test('To domain should return ActivityStatus', () async {
    //act
    final result = tActivityStatusModel.toDomain();
    //expect
    expect(result, isA<ActivityStatus>());
  });
}
