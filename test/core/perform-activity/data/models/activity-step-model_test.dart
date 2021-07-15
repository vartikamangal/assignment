import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/models/activity-step-model.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/entities/activity-step.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  final List<ActivityStepModel> tActivityStepModel = <ActivityStepModel>[
    ActivityStepModel(
        id: 3171,
        stepTitle: 'Content',
        stepHelp: '',
        stepName: 'CONTENT',
        stepSequence: 3,
        iconVO: ImageModel(iconLocator: 'iconLocator', iconType: 'iconType'),
        templateName: 'PLAIN_TEXT',
        stepContent:
            'What is your fondest childhood memory? What made it special?')
  ];

  group('Model ActivityStepModel ', () {
    test('should be an extendor of ActivityStep', () async {
      //assert
      expect(tActivityStepModel.first, isA<ActivityStep>());
    });
    test('fromJson should transform raw-response into ActivityStepModel',
        () async {
      //arrange
      final jsonMap =
          jsonDecode(fixtureReader(filename: 'raw-activity-step.json'))
              as List<dynamic>;
      //act
      final result = jsonMap
          .map((area) =>
              ActivityStepModel.fromJson(area as Map<String, dynamic>))
          .toList();
      //assert
      expect(result, tActivityStepModel);
    });
  });
}
