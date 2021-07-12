import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/activity-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-category-model.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';

void main() {
  const List<ActivityRecommendation> tActivityRecommendationModel =
      <ActivityRecommendationModel>[
    ActivityRecommendationModel(
      id: 'test_id',
      title: 'test',
      subtitle: 'subtitile',
      iconVO: ImageProp(),
      durationInMinutes: 3,
      messageOnReceivingFeedback: 'ddd',
      messageOnCompletion: 'ddd',
      recommendationStatus: 'dddd',
      frequencyMetric: 'test_f',
      frequency: 1,
      actionTime: 'fdd',
      criticality: 'test',
      categoryVO: RecommendationCategoryModel(
          id: 1,
          displaySubtitle: '',
          displayTitle: '',
          iconVO: null,
          categoryDetailedDescription: '',
          categoryName: '',
          categoryShortDescription: ''),
      recommendationStepsVO: [],
      tags: [],
    )
  ];

  group('Model TagModel ', () {
    test('should be an extendor of ActivityRecommendationModel', () async {
      //assert
      expect(tActivityRecommendationModel.first, isA<ActivityRecommendation>());
    });
    // test('fromJson should transform raw-response into ActivityRecommendationModel',
    //         () async {
    //       //arrange
    //       final jsonMap =
    //       jsonDecode(fixtureReader(filename: 'activity-recommendation-model.json'))
    //       as List;
    //       //act
    //       final result = jsonMap
    //           .map((area) =>
    //           ActivityRecommendationModel.fromJson(area as Map<String, dynamic>))
    //           .toList();
    //       //assert
    //       expect(result, tActivityRecommendationModel);
    //     });
    // test('toJson should transform the model into a Map again', () async {
    //   //arrange
    //   final expectedJson =
    //   jsonDecode(fixtureReader(filename: 'activity-recommendation-model.json'))
    //   as List;
    //   //act
    //   final result = tActivityRecommendationModel
    //       .map((area) => (area as ActivityRecommendationModel).toJson())
    //       .toList();
    //   //assert
    //   expect(result, expectedJson);
    // });
  });
}
