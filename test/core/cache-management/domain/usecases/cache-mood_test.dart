import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cached-mood-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/mood-cache-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/cache-mood.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';

class MockMoodCacheService extends Mock implements MoodCacheService {}

void main() {
  MockMoodCacheService service;
  CacheMood useCase;

  setUp(() {
    service = MockMoodCacheService();
    useCase = CacheMood(service: service);
  });

  const tMood = CachedMoodModel(
      moodId: 0, moodName: '', moodDescription: '', moodIcon: ImageProp());
  const tUnit = unit;
  group('USECASE: sevice.cacheMood()', () {
    test('Should cache mood from service', () async {
      when(service.cacheMood(mood: tMood))
          .thenAnswer((_) async => const Right(tUnit));

      final result = await useCase(const CacheMoodParams(mood: tMood));

      verify(service.cacheMood(mood: tMood));
      expect(result, const Right(tUnit));
    });
  });
}
