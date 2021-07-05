// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/life-area-model-for-prioritization.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/life-area-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/life-areas-for-prioritization.dart';
import '../../../../fixtures/fixture-reader.dart';

void main() {
  const tAreas = [
    LifeAreaModel(
      areaCode: "CAREER",
      description: 'Your job, business and aspirations',
      name: 'Career',
    ),
    LifeAreaModel(
      areaCode: "FINANCES",
      description: 'Your relationship with money',
      name: 'Finances',
    ),
    LifeAreaModel(
      areaCode: "HEALTH",
      description: 'Your body, sickness and wellness',
      name: 'Health',
    ),
    LifeAreaModel(
      areaCode: "FAMILY_AND_FRIENDS",
      description: 'Relationships in your life',
      name: 'Family and Friends',
    ),
    LifeAreaModel(
      areaCode: "ROMANCE",
      description: 'Romantic love and partnership',
      name: 'Romance',
    ),
    LifeAreaModel(
      areaCode: "PERSONAL_GROWTH",
      description: 'Aims, goals and aspirations',
      name: 'Personal Growth',
    ),
    LifeAreaModel(
      areaCode: "FUN_AND_RECREATION",
      description: 'Entertainment and leisure',
      name: 'Fun and Recreation',
    ),
    LifeAreaModel(
      areaCode: "PHYSICAL_ENVIRONMENT",
      description: 'Your surroundings',
      name: 'Physical Environment',
    ),
  ];

  const tLifeAreaPrioritizationModel =
      LifeAreaModelForPrioritization(lifeaAreas: tAreas);

  group('Model LifeAreaModelForPrioritization', () {
    test('should be a LifeAreaForPriorization', () async {
      //assert
      expect(tLifeAreaPrioritizationModel, isA<LifeAreaForPrioritization>());
    });
    test('toJson', () async {
      //act
      final result = tLifeAreaPrioritizationModel.toJson();
      //assert
      expect(
        result,
        jsonDecode(
          fixtureReader(filename: 'get-wol-areas-raw-repsonse.json'),
        ) as List?,
      );
    });
  });
}
