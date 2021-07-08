import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cache-acitivity-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/cache-most-recent-activity-local-service.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:matcher/matcher.dart';
import 'package:tatsam_app_experimental/core/persistence-consts.dart';
import 'cache-most-recent-activity-local-service_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  late MockBox localClient;
  late CacheMostRecentAcitivityLocalServiceImpl serviceImpl;

  setUp(() {
    localClient = MockBox();
    serviceImpl = CacheMostRecentAcitivityLocalServiceImpl(
      localClient: localClient,
    );
  });
  const tUnit = unit;
  const tActivityModel = CacheAcitivityModel(
      id: "id", title: "title", subtitle: "subtitle", icon: null);

  group('DATA services for cacheMostRecentActivity', () {
    test('It should return unit when cacheactivity is called', () async {
      when(localClient.put(PersistenceConst.MOST_RECENT_ACITIVITY,
          jsonEncode(tActivityModel.toJson())))
          .thenAnswer((_) async => tUnit);
      final result = await serviceImpl.cacheActivity(acitivity: tActivityModel);
      //assert
      expect(result, tUnit);
    });

    test('should throw CacheException when cacheActivity is failed', () async {
      //arrange
      when(localClient.put(PersistenceConst.MOST_RECENT_ACITIVITY,
          jsonEncode(tActivityModel.toJson())))
          .thenThrow(CacheException());
      //act
      final call = serviceImpl.cacheActivity;
      //assert
      expect(() => call(acitivity: tActivityModel),
          throwsA(const TypeMatcher<CacheException>()));
    });
  });
}