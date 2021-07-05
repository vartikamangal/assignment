import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/recommendation-input.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/recommendation-input-model.dart';
import '../../../../fixtures/fixture-reader.dart';

void main(){
  const List<RecommendationInput> tRecommendatioInput=<RecommendationInputModel>[
    RecommendationInputModel(
      recommendationId: null,
      journeyId: "b059c1d6-e811-41ca-b3f7-4b432e7172de",
      actionId: "19334",
      textFeedback: "",
      voiceNote: null,
      timeOfCreation: "2021-06-23 18:40:39.423980"
    )
  ];

  group('Model RecommendationInputModel ', () {
    test('should be an extendor of RecommendationInputModel', () async {
      //assert
      expect(tRecommendatioInput.first, isA<RecommendationInput>());
    });
    test('fromJson should transform raw-response into RecommendationInputModel',
            () async {
          //arrange
          final jsonMap =
          jsonDecode(fixtureReader(filename: 'recommendation-input-model.json'))
          as List;
          //act
          final result = jsonMap
              .map((area) =>
              RecommendationInputModel.fromJson(area as Map<String, dynamic>))
              .toList();
          //assert
          expect(result, tRecommendatioInput);
        });
    test('toJson should transform the model into a Map again', () async {
      //arrange
      final expectedJson =
      jsonDecode(fixtureReader(filename: 'recommendation-input-model.json'))
      as List?;
      //act
      final result = tRecommendatioInput
          .map((area) => (area as RecommendationInputModel).toJson())
          .toList();
      //assert
      expect(result, expectedJson);
    });
  });
}