import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cached-mood-model.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/entities/cached-mood.dart';
import '../../../../fixtures/fixture-reader.dart';

void main(){
  const tMoodModel = CachedMoodModel( moodId: 1,
    moodName: 'VERY_BAD',
    moodDescription: 'Very sad',
    moodIcon: null,);
  group('MODEL CachedMoodModel ', () {
    test('should be a extended version of CachedMood', () async {
      //assert
      expect(tMoodModel, isA<CachedMood>());
    });
    test(' .fromJson should return a valid cachedMood', () async {
      //arrange
      final jsonMap = jsonDecode(fixtureReader(filename: 'raw-cached-mood.json'))
      as List<dynamic>;
      //act
      final result = CachedMoodModel.fromJson(jsonMap.first as Map<String, dynamic>);
      //assert
      expect(result, tMoodModel);
    });
    test('toJson should return a properly parsed Map from the model', () async {
      //act
      final result = tMoodModel.toJson();
      //assert
      expect(result, jsonDecode(fixtureReader(filename: 'single-cached-mood.json')));
    });
  });

}