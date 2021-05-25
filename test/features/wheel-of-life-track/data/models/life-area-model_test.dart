import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/life-area-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/life-area.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const LifeArea tModel = LifeAreaModel(
    areaCode: 'CAREER',
    name: 'Career',
    description: 'Your job, business and aspirations',
  );

  group('Model LifeAreaModel', () {
    test('should be a LifeArea', () async {
      //assert
      expect(tModel, isA<LifeArea>());
    });
    test('fromJson should parse the feeded json into a LifeAreaModel',
        () async {
      //arrange
      final jsonMap = jsonDecode(
        fixtureReader(filename: 'get-wol-areas-raw-repsonse.json'),
      ) as List;
      //act
      final result = LifeAreaModel.fromJson(jsonMap[0] as Map<String, dynamic>);
      //assert
      expect(result, tModel);
    });
    test('toJson should change the LifeAreaModel into a json format', () async {
      //arrange
      final expectedJson = {
        "areaName": "CAREER",
        "displayName": "Career",
        "areaDescription": "Your job, business and aspirations",
      };
      //act
      final result = (tModel as LifeAreaModel).toJson();
      //assert
      expect(result, expectedJson);
    });
  });
}
