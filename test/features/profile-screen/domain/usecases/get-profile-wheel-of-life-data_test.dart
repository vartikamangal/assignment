// Package Import:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
// Project Import:
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/focus/domain/entities/issue.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/default-rating-scale.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/hub-status.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/individual-satisfaction-rating-result.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/life-priority-list.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/life-rating-result.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/target-focus-list.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/repositories/profile-details-repository.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/usecases/get-profile-wheel-of-life-data.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-id-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-information-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/subject-id.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/subject-information.dart';

class MockProfileDetailsRepository extends Mock
    implements ProfileDetailsRepository {}

void main() {
  MockProfileDetailsRepository repository;
  GetProfileWheelOfLifeData useCase;

  setUp(() {
    repository = MockProfileDetailsRepository();
    useCase = GetProfileWheelOfLifeData(repository: repository);
  });
  final newMap = <String, LifeRatingResult>{};
  newMap[' '] = LifeRatingResult(
      id: 0,
      subjectId: const SubjectId(''),
      wolArea: '',
      rating: const IndividualSatisfactionRating(
          id: 0,
          rating: 0,
          scale: DefaultRatingScale(
              id: 0,
              ratingScaleName: '',
              minValue: 0,
              maxValue: 0,
              icon: ImageProp())),
      createdWhen: DateTime.now());

  final tHubStatus = HubStatus(
      id: 0,
      subjectInformation: const SubjectInformationModel(
          subjectId: SubjectIdModel(id: ''),
          userID: '',
          name: '',
          nickName: '',
          deviceIndentifier: '',
          gender: Gender.Male),
      targetFocus: const TargetFocusList(id: 0, targetFocusList: [
        Issue(
            issueId: 0,
            issueIcon: ImageProp(),
            displayName: '',
            focusName: '',
            messageOnSelection: '')
      ]),
      lifePriorities: const LifePriorities(id: 0, areasInOrderOfPriority: ['']),
      lifeSatisfactionRatings: newMap,
      attemptedQuestions: true);

  group("USECASE : getProfileQuestions()", () {
    test('should get all the profile question logs from the repository',
        () async {
      //arrange
      when(repository.getProfileWheelOfLifeData())
          .thenAnswer((_) async => Right(tHubStatus));
      //act
      final result = await useCase(NoParams());
      //assert
      verify(repository.getProfileWheelOfLifeData());
      expect(result, Right(tHubStatus));
    });
  });
}
