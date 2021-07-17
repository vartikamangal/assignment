import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/default-rating-scale-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/individual-satisfaction-rating-result-model.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/individual-satisfaction-rating-result.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  final tRatingModel = IndividualSatisfactionRatingResultModel(
      id: 0,
      rating: 0,
      scale: DefaultRatingScaleModel(
        id: 0,
        ratingScaleName: null,
        minValue: 0,
        maxValue: 0,
        icon: ImageModel.fromDomain(
          ImageEntity(
              type: 'URL', url: 'https://images.tatsam.in/Logo+512+x+512.png'),
        ),
      ));
  group('Model IndividualSatisfactionRatingResultModel', () {
    test('should be a extended version of IndividualSatisfactionRating',
        () async {
      expect(tRatingModel, isA<IndividualSatisfactionRating>());
    });
  });
}
