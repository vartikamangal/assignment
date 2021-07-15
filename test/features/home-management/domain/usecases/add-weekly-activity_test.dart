import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/features/home-management/domain/repositories/add-weekly-category-service.dart';
import 'package:tatsam_app_experimental/features/home-management/domain/usecases/add-weekly-activity.dart';
import 'add-weekly-activity_test.mocks.dart';

@GenerateMocks([AddWeeklyCategoryService])
void main() {
  late MockAddWeeklyCategoryService service;
  late AddWeeklyActivity useCase;

  const tCategory = '';
  const tRecommendationId = '';
  const tUnit = unit;

  setUp(() {
    service = MockAddWeeklyCategoryService();
    useCase = AddWeeklyActivity(service: service);
  });
  group('USECASE: addWeeklyActivity()', () {
    test('should add weekly activity to service', () async {
      when(service.addWeeklyActivity(
              category: tCategory, recommendationId: tRecommendationId))
          .thenAnswer((_) async => const Right(tUnit));

      final result = await useCase(const AddWeeklyActivityParams(
          category: tCategory, recommendationId: tRecommendationId));

      verify(service.addWeeklyActivity(
          category: tCategory, recommendationId: tRecommendationId));

      expect(result, const Right(tUnit));
    });
  });
}
