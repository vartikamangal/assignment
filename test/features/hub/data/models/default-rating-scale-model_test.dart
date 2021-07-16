import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/default-rating-scale-model.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/default-rating-scale.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  final tDefaultRatingScaleModel = DefaultRatingScaleModel(
    id: 0,
    ratingScaleName: null,
    minValue: 0,
    maxValue: 0,
    icon: null,
  );
  group('Model DefaultRatingScaleModel', () {
    test('should be a extended version of DefaultRatingScale', () async {
      expect(tDefaultRatingScaleModel, isA<DefaultRatingScale>());
    });
  });
}
