import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/default-rating-scale-model.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/default-rating-scale.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const tDefaultRatingScaleModel = DefaultRatingScaleModel(
    id: 0,
    ratingScaleName: null,
    minValue: 0,
    maxValue: 0,
    icon: ImageProp(urlShort: '', urlMedium: '', urlLarge: ''),
  );
  group('Model DefaultRatingScaleModel', () {
    test('should be a extended version of DefaultRatingScale', () async {
      expect(tDefaultRatingScaleModel, isA<DefaultRatingScale>());
    });

    test('fromJson should transform raw-response into InstantReliefAreaModel',
        () async {
      //arrange
      final jsonMap =
          jsonDecode(fixtureReader(filename: 'default-rating-scale.json'))
              as List<dynamic>;
      //act
      final result = DefaultRatingScaleModel.fromJson(
          jsonMap.first as Map<String, dynamic>);
      //assert
      expect(result, tDefaultRatingScaleModel);
    });
  });
}
