
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cache-acitivity-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/entities/cache-acitivty.dart';

import '../../../../fixtures/fixture-reader.dart';

void main(){
  const List<CacheAcitivty> tcacheActivityModel=<CacheAcitivityModel>[CacheAcitivityModel(id: "1", title: "title", subtitle: "subtitle", icon: null)];
  group('Model CacheAcitivityModel ', () {
    test('should be an extendor of cacheActivityModel', () async {
      //assert
      expect(tcacheActivityModel.first, isA<CacheAcitivty>());
    });
    test('fromJson should transform raw-response into CacheAcitivityModel',
            () async {
          //arrange
          final jsonMap =
          jsonDecode(fixtureReader(filename: 'raw-cache-activity.json'))
          as List;
          //act
          final result = jsonMap
              .map((area) =>
              CacheAcitivityModel.fromJson(area as Map<String, dynamic>))
              .toList();
          //assert
          expect(result, tcacheActivityModel);
        });
    test('toJson should transform the model into a Map again', () async {
      //arrange
      final expectedJson =
      jsonDecode(fixtureReader(filename: 'raw-cache-activity.json'))
      as List?;
      //act
      final result = tcacheActivityModel
          .map((area) => (area as CacheAcitivityModel).toJson())
          .toList();
      //assert
      expect(result, expectedJson);
    });
  });
}
