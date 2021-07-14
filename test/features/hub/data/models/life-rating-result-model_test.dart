import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/default-rating-scale-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/individual-satisfaction-rating-result-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/life-rating-result-model.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/life-rating-result.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-id-model.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  final tLifeRatingResultModel = LifeRatingResultModel(
      id: null,
      subjectId: const SubjectIdModel(id: 'id'),
      wolArea: null,
      rating: const IndividualSatisfactionRatingResultModel(
          id: 0,
          rating: 0,
          scale: DefaultRatingScaleModel(
              id: 0,
              ratingScaleName: 'ratingScaleName',
              minValue: 0,
              maxValue: 100,
              icon: "")),
      createdWhen: DateTime.parse('2021-05-10T13:19:41.543Z'));
  group('Model LifeRatingResultModel', () {
    test('should be a extended version of LifeRatingResult', () async {
      expect(tLifeRatingResultModel, isA<LifeRatingResult>());
    });

    test('fromJson should transform raw-response into LifeRatingResultModel',
        () async {
      //arrange
      final jsonMap =
          jsonDecode(fixtureReader(filename: 'life-rating-result-model.json'))
              as List<dynamic>;
      //act
      final result =
          LifeRatingResultModel.fromJson(jsonMap.first as Map<String, dynamic>);
      //assert
      expect(result, tLifeRatingResultModel);
    });
  });
}
