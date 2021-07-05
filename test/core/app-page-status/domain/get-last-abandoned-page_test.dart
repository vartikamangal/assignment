import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/app-page-status/domain/entities/app-route.dart';
import 'package:tatsam_app_experimental/core/app-page-status/domain/repository/app-page-status-repository.dart';
import 'package:tatsam_app_experimental/core/app-page-status/domain/usecases/get-last-abandoned-page.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/hub-status-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/life-priority-list-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/target-focus-list-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-id-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-information-model.dart';

import 'get-last-abandoned-page_test.mocks.dart';

@GenerateMocks([AppPageStatusRepository])
void main() {
  late MockAppPageStatusRepository repository;
  late GetLastAbandonedPage usecase;

  setUp(() {
    repository = MockAppPageStatusRepository();
    usecase = GetLastAbandonedPage(repository: repository);
  });

  const tHubStatus = HubStatusModel(
    id: 1,
    subjectInformation: SubjectInformationModel(
      name: 'Test user',
      nickName: 'testyy',
      gender: null,
      subjectId: SubjectIdModel(id: ''),
      userID: '',
      deviceIndentifier: 'test_device_id',
    ),
    targetFocus: TargetFocusListModel(id: 1, targetFocusList: []),
    lifePriorities: LifePrioritiesModel(id: 1, areasInOrderOfPriority: []),
    lifeSatisfactionRatings: {},
    attemptedQuestions: false,
    journeyPath: null,
    journeyStartedAt: null,
    journeyStatus: null,
    latestMood: 'GOOD',
  );

  const tAppRoute = AppRoute(name: '/rapport');

  group('USECASE: getLastAbandonedPage', () {
    test(
        'should get the [AppRoute] of most recently left page by user while onboarding',
        () async {
      //arrange
      when(
        repository.getLastAbandonedPage(hubStatusModel: tHubStatus),
      ).thenAnswer((_) async => const Right(tAppRoute));
      //act
      final Either<Failure, AppRoute> result = await usecase(
        const GetLastAbandonedPageParams(hubStatusModel: tHubStatus),
      );
      //assert
      verify(repository.getLastAbandonedPage(hubStatusModel: tHubStatus));
      expect(result, const Right(tAppRoute));
    });
  });
}
