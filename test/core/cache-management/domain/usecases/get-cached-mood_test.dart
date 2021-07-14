import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cached-mood-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/entities/cached-mood.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/mood-cache-service.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/get-cached-mood.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

import 'cache-mood_test.mocks.dart';

@GenerateMocks([MoodCacheService])
void main() {
  late MockMoodCacheService service;
  late GetCachedMood useCase;

  setUp(() {
    service = MockMoodCacheService();
    useCase = GetCachedMood(service: service);
  });
  const tMood1 = CachedMoodModel(
      moodId: 0, moodName: '', moodDescription: '', moodIcon: ImageEntity());
  // TODO Resolve daubt.
  const tMood = CachedMood(
      moodId: 0, moodName: '', moodDescription: '', moodIcon: ImageEntity());
  group('USECASE: service.getCacheMood()', () {
    test('Should get cached mood from service', () async {
      when(service.getCacheMood()).thenAnswer((_) async => const Right(tMood1));

      final result = await useCase(NoParams());
      verify(service.getCacheMood());
      expect(result, const Right(tMood1));
    });
  });
}
