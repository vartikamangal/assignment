import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cache-acitivity-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/cache-most-recent-acitivity-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/cache-most-recent-acitivity.dart';

class MockCacheMostRecentActivityService extends Mock
    implements CacheMostRecentAcitivtyService {}

void main() {
  MockCacheMostRecentActivityService service;
  CacheMostRecentAcitivity useCase;

  setUp(() {
    service = MockCacheMostRecentActivityService();
    useCase = CacheMostRecentAcitivity(service: service);
  });

  const tActivity =
      CacheAcitivityModel(id: '', title: '', subtitle: '', icon: '');

  const tUnit = unit;
  group('USECASE: service.cacheActivity()', () {
    test('Should cache most recent activity', () async {
      when(service.cacheActivity(acitivity: tActivity))
          .thenAnswer((_) async => const Right(tUnit));

      final result = await useCase(
          const CacheMostRecentAcitivityParams(acitivity: tActivity));
      verify(service.cacheActivity(acitivity: tActivity));
      expect(result, const Right(tUnit));
    });
  });
}
