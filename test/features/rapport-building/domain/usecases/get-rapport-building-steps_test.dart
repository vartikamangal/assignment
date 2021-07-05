import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/rapport-building-steps.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/rapport-step.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/repositories/rapport-building-repository.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/usecases/get-rapport-building-steps.dart';

class MockGetRapportBuildingStepsRepository extends Mock
    implements RapportBuildingRepository {}

void main() {
  MockGetRapportBuildingStepsRepository repository;
  late GetRapportBuildingSteps usecase;
  setUp(() {
    repository = MockGetRapportBuildingStepsRepository();
    usecase = GetRapportBuildingSteps(repository: repository);
  });
  const tMood = Mood(
    moodId: 1,
    moodName: 'VERY_GOOD',
    moodDescription: 'some random mood description',
    moodIcon: null,
  );
  const tStepContent = RapportBuildingSteps(rapportSteps: [
    RapportStep(
      id: 1,
      stepTitle: 'Test title',
      stepContent: 'test content',
      stepHelp: 'Test help',
      stepDescription: 'test descrption',
      stepSequence: 1,
      icon: null,
      templateName: 'test_template_1',
    ),
    RapportStep(
      id: 1,
      stepTitle: 'Test title',
      stepContent: 'test content',
      stepHelp: 'Test help',
      stepDescription: 'test descrption',
      stepSequence: 1,
      icon: null,
      templateName: 'test_template_3',
    ),
    RapportStep(
      id: 1,
      stepTitle: 'Test title',
      stepContent: 'test content',
      stepHelp: 'Test help',
      stepDescription: 'test descrption',
      stepSequence: 1,
      icon: null,
      templateName: 'test_template_2',
    ),
  ]);
  group('USECASE[RAPPORT] : getRapportBuildingSteps', () {
    test("""should fetch [RapportBuildingSteps] from the repository""",
        () async {
      //arrange
      when(repository.getRapportBuildingSteps(mood: tMood))
          .thenAnswer((_) async => right(tStepContent));
      //act
      final result = await usecase(
        const GetRapportBuildingStepsParams(mood: tMood),
      );
      //assert
      verify(repository.getRapportBuildingSteps(mood: tMood));
      expect(result, right(tStepContent));
    });
  });
}
