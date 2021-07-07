import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/hub-status.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/life-priority-list.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/target-focus-list.dart';
import 'package:tatsam_app_experimental/features/hub/domain/repository/get-hub-status-repository.dart';
import 'package:tatsam_app_experimental/features/hub/domain/usecases/get-hub-status.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-id-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-information-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/subject-information.dart';
import 'get-hub-status_test.mocks.dart';

@GenerateMocks([GetHubStatusRepository])

void main() {
  late MockGetHubStatusRepository repository;
  late GetHubStatus usecase;

  setUp(() {
    repository = MockGetHubStatusRepository();
    usecase = GetHubStatus(repository: repository);
  });

  const tHubStatus = HubStatus(
    id: 1,
    subjectInformation: SubjectInformationModel(
      subjectId: SubjectIdModel(id: ''),
      userID: '',
      name: 'test',
      nickName: 'test',
      deviceIndentifier: 'sssssswwwww',
      gender: Gender.Male,
    ),
    targetFocus: TargetFocusList(id: 1, targetFocusList: []),
    lifePriorities: LifePriorities(id: 1, areasInOrderOfPriority: []),
    lifeSatisfactionRatings: {},
    attemptedQuestions: false,
    userMood: null,
    journey: null,
    journeyStartedAt: null,
    journeyStatus: null,
  );

  group('Usecase: GetHubStatus', () {
    test(
        'Should get the Hubstatus with the help of passed in [MockGetHubStatusRepository]',
        () async {
      //arrange
      when(repository.getHubStatus())
          .thenAnswer((_) async => const Right(tHubStatus));
      //act
      final result = await usecase(NoParams());
      //assert
      verify(repository.getHubStatus());
      expect(result, const Right(tHubStatus));
    });
  });
}
