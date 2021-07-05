import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/recommendation-category-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/recommendation-category.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const List<RecommendationCategory> tRecommendationCategoryModel =
      <RecommendationCategoryModel>[
    RecommendationCategoryModel(
      id: 2,
      categoryName: "MENTAL",
      displayTitle: "Mental",
      displaySubtitle: "Focus on your mind",
      categoryDetailedDescription: "This is mental category",
      categoryShortDescription: "Focus on your mind",
      iconVO: ImageProp(urlShort: null, urlLarge: null, urlMedium: null),
    )
  ];

  group('Model RecommendationCategoryModel ', () {
    test('should be an extendor of RecommendationCategoryModel', () async {
      //assert
      expect(tRecommendationCategoryModel.first, isA<RecommendationCategory>());
    });
    test(
        'fromJson should transform raw-response into RecommendationCategoryModel',
        () async {
      //arrange
      final jsonMap = jsonDecode(
              fixtureReader(filename: 'recommendation-category-model.json'))
          as List;
      //act
      final result = jsonMap
          .map((area) => RecommendationCategoryModel.fromJson(
              area as Map<String, dynamic>))
          .toList();
      //assert
      expect(result, tRecommendationCategoryModel);
    });
    test('toJson should transform the model into a Map again', () async {
      //arrange
      final expectedJson = jsonDecode(
              fixtureReader(filename: 'recommendation-category-model.json'))
          as List?;
      //act
      final result = tRecommendationCategoryModel
          .map((area) => (area as RecommendationCategoryModel).toJson())
          .toList();
      //assert
      expect(result, expectedJson);
    });
  });
}
