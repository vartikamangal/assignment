import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation-category.dart';
import 'package:tatsam_app_experimental/core/activity/domain/repositories/get-all-recommendation-catoegories-repository.dart';
import 'package:tatsam_app_experimental/core/activity/domain/usecases/get-all-recommendation-categories.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';

import 'get-all-recommendation-categories_test.mocks.dart';

@GenerateMocks([GetAllRecommendationCategoriesRepository])
void main() {
  late MockGetAllRecommendationCategoriesRepository repository;
  late GetAllRecommendationCategories useCase;

  setUp(() {
    repository = MockGetAllRecommendationCategoriesRepository();
    useCase = GetAllRecommendationCategories(repository: repository);
  });

  const tRecommendationCategories = <RecommendationCategory>[
    RecommendationCategory(
        id: 1,
        categoryName: "PHYSICAL",
        displayTitle: "Physical",
        displaySubtitle: "Focus on the body",
        categoryDetailedDescription: "This is physical category",
        categoryShortDescription: "Focus on the body",
        iconVO: null),
    RecommendationCategory(
        id: 2,
        categoryName: "MENTAL",
        displayTitle: "Mental",
        displaySubtitle: "Focus on your mind",
        categoryDetailedDescription: "This is mental category",
        categoryShortDescription: "Focus on your mind",
        iconVO: null),
    RecommendationCategory(
        id: 3,
        categoryName: "EMOTIONAL",
        displayTitle: "Emotional",
        displaySubtitle: "Focus on your relationships",
        categoryDetailedDescription: "This is emotional category",
        categoryShortDescription: "Focus on your relationships",
        iconVO: null),
    RecommendationCategory(
        id: 4,
        categoryName: "SPIRITUAL",
        displayTitle: "Spiritual",
        displaySubtitle: "Focus on the world around",
        categoryDetailedDescription: "This is Spiritual category",
        categoryShortDescription: "Focus on the world around",
        iconVO: null),
  ];

  group('USECASE : getAllCategories', () {
    test('should return a list of issues using repository', () async {
      //arrange
      when(repository.getAllCategories())
          .thenAnswer((_) async => const Right(tRecommendationCategories));
      //act
      final result = await useCase(NoParams());
      //assert
      verify(repository.getAllCategories());
      expect(result, const Right(tRecommendationCategories));
    });
  });
}
