import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-category-model.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation-category.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  final recommendationModel = RecommendationCategory(
      id: 2,
      categoryName: 'categoryName',
      displayTitle: 'displayTitle',
      displaySubtitle: 'displaySubtitle',
      categoryDetailedDescription: 'categoryDetailedDescription',
      categoryShortDescription: 'categoryShortDescription',
      iconVO: ImageEntity(type: 'type', url: 'url'));

  final tRecommendationCategoryModel = RecommendationCategoryModel.fromDomain(
      RecommendationCategory(
          id: 2,
          categoryName: 'categoryName',
          displayTitle: 'displayTitle',
          displaySubtitle: 'displaySubtitle',
          categoryDetailedDescription: 'categoryDetailedDescription',
          categoryShortDescription: 'categoryShortDescription',
          iconVO: ImageEntity(type: 'type', url: 'url')));

  test('from domain to take entity and covert in RecommendationCategoryModel',
      () async {
    //act
    final result = RecommendationCategoryModel.fromDomain(recommendationModel);
    //expect
    expect(result, isA<RecommendationCategoryModel>());
  });

  test('from json should return valid RecommendationCategoryModel', () async {
    //arrange
    final jsonMap = jsonDecode(fixtureReader(
        filename: 'raw-recommendation-category-model-from.json')) as List;
    //act
    final result = RecommendationCategoryModel.fromJson(
        jsonMap.first as Map<String, dynamic>);

    //expect
    expect(result.toString(), tRecommendationCategoryModel.toString());
  });

  test(
      'To json of RecommendationCategoryModel should return a json RecommendationCategoryModel',
      () async {
    //arrange
    final jsonMap = jsonDecode(fixtureReader(
            filename: 'raw-recommendation-category-model-to.json'))
        as List<dynamic>;
    //act
    final j = tRecommendationCategoryModel.toJson();
    //expect
    expect(jsonMap.first, j);
  });
  test('To domain should return RecommendationCategory', () async {
    //act
    final result = tRecommendationCategoryModel.toDomain();
    //expect
    expect(result, isA<RecommendationCategory>());
  });
}
