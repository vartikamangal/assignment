import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/recommendation-activity.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/recommendation-category.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/recommendation-step.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/tag.dart';
import 'package:tatsam_app_experimental/features/home-management/domain/repositories/get-recommendations-by-action-time-repository.dart';
import 'package:tatsam_app_experimental/features/home-management/domain/usecases/get-recommendations-by-action-time.dart';
import 'get-recommendations-by-action-time_test.mocks.dart';

@GenerateMocks([GetRecommendationsByActionTimeRepository])

void main() {
  late MockGetRecommendationsByActionTimeRepository repository;
  late GetRecommendationsByActionTime useCase;

  const tActionTime = '';

  const tRecommendationCategory = RecommendationCategory(
      id: 1,
      categoryName: '',
      displayTitle: '',
      displaySubtitle: '',
      categoryDetailedDescription: '',
      categoryShortDescription: '',
      iconVO: null);

  const tRecommendationStep = [
    RecommendationStep(
        id: 1,
        stepTitle: 'stepTitle',
        stepHelp: 'stepHelp',
        stepName: 'stepName',
        stepSequence: 1,
        iconVO: null,
        templateName: 'templateName',
        stepContent: 'stepContent')
  ];

  const tTag = [
    Tag(
        name: 'name',
        tagCategory: 'tagCategory',
        displayName: 'displayName',
        parentName: 'parentName')
  ];

  const tActivityRecommendation = [
    ActivityRecommendation(
        id: '',
        title: 'title',
        subtitle: 'subtitle',
        iconVO: null,
        durationInMinutes: 1,
        messageOnReceivingFeedback: 'messageOnReceivingFeedback',
        messageOnCompletion: 'messageOnCompletion',
        recommendationStatus: 'recommendationStatus',
        frequencyMetric: 'frequencyMetric',
        frequency: 1,
        actionTime: 'actionTime',
        criticality: 'criticality',
        categoryVO: tRecommendationCategory,
        recommendationStepsVO: tRecommendationStep,
        tags: tTag)
  ];

  setUp(() {
    repository = MockGetRecommendationsByActionTimeRepository();
    useCase = GetRecommendationsByActionTime(repository: repository);
  });
  group('USECASE: getRecommendations()', () {
    test('should get recommendations by action time from repository ...',
            () async {
          when(repository.getRecommendations(actionTime: tActionTime))
              .thenAnswer((_) async => const Right(tActivityRecommendation));

          final result = await useCase(
              const GetRecommendationsByActionTimeParams(actionTime: tActionTime));
          verify(repository.getRecommendations(actionTime: tActionTime));
          expect(result, const Right(tActivityRecommendation));
        });
  });
}
