import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-step-model.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation-step.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const List<RecommendationStep> tRecommendationStep =
      <RecommendationStepModel>[
    RecommendationStepModel(
        id: 3171,
        stepTitle: "Content",
        stepHelp: "",
        stepName: "CONTENT",
        stepSequence: 3,
        iconVO: ImageProp(urlShort: null, urlLarge: null, urlMedium: null),
        templateName: "PLAIN_TEXT",
        stepContent:
            "What is your fondest childhood memory? What made it special?")
  ];
  group('Model RecommendationStepModel ', () {
    test('should be an extendor of RecommendationStepModel', () async {
      //assert
      expect(tRecommendationStep.first, isA<RecommendationStep>());
    });
    test('fromJson should transform raw-response into RecommendationStepModel',
        () async {
      //arrange
      final jsonMap =
          jsonDecode(fixtureReader(filename: 'raw-recommendation-step.json'))
              as List;
      //act
      final result = jsonMap
          .map((area) =>
              RecommendationStepModel.fromJson(area as Map<String, dynamic>))
          .toList();
      //assert
      expect(result, tRecommendationStep);
    });
    test('toJson should transform the model into a Map again', () async {
      //arrange
      final expectedJson =
          jsonDecode(fixtureReader(filename: 'raw-recommendation-step.json'))
              as List?;
      //act
      final result = tRecommendationStep
          .map((area) => (area as RecommendationStepModel).toJson())
          .toList();
      //assert
      expect(result, expectedJson);
    });
  });
}
