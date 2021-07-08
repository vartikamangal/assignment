import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-category-model.dart';
import 'package:tatsam_app_experimental/features/home-management/domain/repositories/add-weekly-category-service.dart';
import 'package:tatsam_app_experimental/features/home-management/domain/usecases/add-weekly-category.dart';
import 'add-weekly-category_test.mocks.dart';

@GenerateMocks([AddWeeklyCategoryService])
void main() {
  late MockAddWeeklyCategoryService service;
  late AddWeeklyCategory useCase;

  const tWeekNumber = 1;
  const tRecommendationCategory = RecommendationCategoryModel(
      id: 1,
      categoryName: '',
      displayTitle: '',
      displaySubtitle: '',
      categoryDetailedDescription: '',
      categoryShortDescription: '',
      iconVO: null);

  const tUnit = unit;

  setUp(() {
    service = MockAddWeeklyCategoryService();
    useCase = AddWeeklyCategory(service: service);
  });
  group('USECASE: addWeeklyCategory()', () {
    test('should add weekly category to service ...', () async {
      when(service.addWeeklyCategory(
              weekNumber: tWeekNumber, category: tRecommendationCategory))
          .thenAnswer((_) async => const Right(tUnit));

      final result = await useCase(const AddWeeklyCategoryParams(
          weekNumber: tWeekNumber, category: tRecommendationCategory));

      verify(service.addWeeklyCategory(
          weekNumber: tWeekNumber, category: tRecommendationCategory));

      expect(result, const Right(tUnit));
    });
  });
}
