import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cached-mood-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/mood-cache-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/cache-mood.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';

import 'cache-mood_test.mocks.dart';

@GenerateMocks([MoodCacheService])
void main() {
  late MockMoodCacheService service;
  late CacheMood useCase;

  setUp(() {
    service = MockMoodCacheService();
    useCase = CacheMood(service: service);
  });

  final tMood = CachedMoodModel(
      moodId: 0,
      moodName: '',
      moodDescription: '',
      moodIcon: ImageEntity(type: '', url: ''));
  const tUnit = unit;
  group('USECASE: sevice.cacheMood()', () {
    test('Should cache mood from service', () async {
      when(service.cacheMood(mood: tMood))
          .thenAnswer((_) async => const Right(tUnit));

      final result = await useCase(CacheMoodParams(mood: tMood));

      verify(service.cacheMood(mood: tMood));
      expect(result, const Right(tUnit));
    });
  });
}
