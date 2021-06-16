// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/rating-scale-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/rating-scale.dart';
import '../../../../fixtures/fixture-reader.dart';

void main() {
  final tRatingScale = RatingScaleModel(
    min: 0,
    max: 0,
    ratingValue: 0,
    ratingScaleName: null,
  );
  group('Model RatingScaleModel', () {
    test('should be a RatingScale', () async {
      //assert
      expect(tRatingScale, isA<RatingScale>());
    });
    test('fromJson should return a RatingScaleModel from jsonMap', () async {
      //arrange
      final jsonMap = jsonDecode(
        fixtureReader(filename: 'get-rating-scale-raw-response.json'),
      );
      //act
      final result = RatingScaleModel.fromJson(jsonMap as Map<String, dynamic>);
      //assert
      expect(result, tRatingScale);
    });
    test('toJson should return a Map from used RatingScaleModel', () async {
      //arrange
      final expectedJson = jsonDecode(
          fixtureReader(filename: 'get-rating-scale-raw-response.json'));
      //act
      final result = tRatingScale.toJson();
      //assert
      expect(result, expectedJson);
    });
  });
}
