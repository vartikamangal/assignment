import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/default-rating-scale-model.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/default-rating-scale.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  final tDefaultRatingScaleModel = DefaultRatingScaleModel(
    id: 0,
    ratingScaleName: "multiple type",
    minValue: 0,
    maxValue: 0,
    icon: ImageModel.fromDomain(
      ImageEntity(
          type: 'URL', url: 'https://images.tatsam.in/Logo+512+x+512.png'),
    ),
  );

  group('Model DefaultRatingScaleModel', () {
    test('should be a extended version of DefaultRatingScale', () async {
      expect(tDefaultRatingScaleModel, isA<DefaultRatingScale>());
    });
    // test('fromJson should transform raw-response into DefaultRatingScaleModel',
    //         () async {
    //       //arrange
    //       final jsonMap =
    //       jsonDecode(fixtureReader(filename: 'default-rating-scale.json'))
    //       as List<dynamic>;
    //       //act
    //       final result =
    //       DefaultRatingScaleModel.fromJson(jsonMap.first as Map<String, dynamic>);
    //       //assert
    //       expect(result, tDefaultRatingScaleModel);
    //     });
  });
}
