import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cached-mood-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/mood-cache-local-service.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/persistence-consts.dart';
import 'mood-cache-local-service_test.mocks.dart';
import 'package:matcher/matcher.dart';

@GenerateMocks([Box])
void main() {
  late MockBox localClient;
  late MoodCacheLocalServiceImpl serviceImpl;

  setUp(() {
    localClient = MockBox();
    serviceImpl = MoodCacheLocalServiceImpl(
      localClient: localClient,
    );
  });

  const tUnit = unit;

  const tCachedMoodModel = CachedMoodModel(
      moodId: 1,
      moodName: "Neutral",
      moodDescription: "moodDescription",
      moodIcon: null);

  group('DATA SOURCE : moodCache', () {
    test('should cache mood from the service', () async {
      //arrange
      when(localClient.put(PersistenceConst.USER_MOOD,
          jsonEncode(tCachedMoodModel.toJson())))
          .thenAnswer((_) async => tUnit);
      //act
      final result =
      await serviceImpl.cacheMood(cachedMoodModel: tCachedMoodModel);
      //assert
      verify(localClient.put(
          PersistenceConst.USER_MOOD, jsonEncode(tCachedMoodModel.toJson())));
      expect(result, tUnit);
    });

    test('should throw CacheException when cacheMood is failed', () async {
      //arrange
      when(localClient.put(PersistenceConst.USER_MOOD,
          jsonEncode(tCachedMoodModel.toJson())))
          .thenThrow(CacheException());
      //act
      final call = serviceImpl.cacheMood(cachedMoodModel: tCachedMoodModel);
      //assert
      expect(() => call, throwsA(const TypeMatcher<CacheException>()));
    });
  });
}