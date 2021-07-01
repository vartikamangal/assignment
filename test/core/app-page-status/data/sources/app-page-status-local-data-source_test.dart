import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/app-page-status/data/models/app-route-model.dart';
import 'package:tatsam_app_experimental/core/app-page-status/data/repository/app-page-status-repository-impl.dart';
import 'package:tatsam_app_experimental/core/app-page-status/data/sources/app-page-status-local-data-source.dart';
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/features/focus/data/models/issue-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/default-rating-scale-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/hub-status-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/individual-satisfaction-rating-result-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/life-priority-list-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/life-rating-result-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/target-focus-list-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-id-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-information-model.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/models/journey-model.dart';

void main() {
  AppPageStatusLocalDataSourceImpl localDataSourceImpl;

  setUp(() {
    localDataSourceImpl = AppPageStatusLocalDataSourceImpl();
  });

  const tHubStatusOnlyNickname = HubStatusModel(
    id: 1,
    subjectInformation: SubjectInformationModel(
      name: 'Test user',
      nickName: 'testyy',
      gender: null,
      subjectId: SubjectIdModel(id: ''),
      userID: '',
      deviceIndentifier: 'test_device_id',
    ),
    targetFocus: null,
    lifePriorities: null,
    lifeSatisfactionRatings: null,
    attemptedQuestions: false,
    journeyPath: null,
    journeyStartedAt: null,
    journeyStatus: null,
    latestMood: null,
  );
  const tAppRouteForUptoMood = AppRouteModel(name: RouteName.rapportPages);
  const tHubStatusUptoMood = HubStatusModel(
    id: 1,
    subjectInformation: SubjectInformationModel(
      name: 'Test user',
      nickName: 'testyy',
      gender: null,
      subjectId: SubjectIdModel(id: ''),
      userID: '',
      deviceIndentifier: 'test_device_id',
    ),
    targetFocus: null,
    lifePriorities: null,
    lifeSatisfactionRatings: null,
    attemptedQuestions: false,
    journeyPath: null,
    journeyStartedAt: null,
    journeyStatus: null,
    latestMood: 'GOOD',
  );
  const tAppRouteForOnlyNickname = AppRouteModel(name: RouteName.rapportPages);
  const tHubStatusUptoPriorities = HubStatusModel(
    id: 1,
    subjectInformation: SubjectInformationModel(
      name: 'Test user',
      nickName: 'testyy',
      gender: null,
      subjectId: SubjectIdModel(id: ''),
      userID: '',
      deviceIndentifier: 'test_device_id',
    ),
    targetFocus: null,
    lifePriorities: LifePrioritiesModel(id: 1, areasInOrderOfPriority: [
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
    ]),
    lifeSatisfactionRatings: null,
    attemptedQuestions: false,
    journeyPath: null,
    journeyStartedAt: null,
    journeyStatus: null,
    latestMood: null,
  );
  const tAppRouteForUptoPriorities = AppRouteModel(name: RouteName.hubScreen);
  final tHubStatusUptoSatisfactionRatings = HubStatusModel(
    id: 1,
    subjectInformation: const SubjectInformationModel(
      name: 'Test user',
      nickName: 'testyy',
      gender: null,
      subjectId: SubjectIdModel(id: ''),
      userID: '',
      deviceIndentifier: 'test_device_id',
    ),
    targetFocus: null,
    lifePriorities: const LifePrioritiesModel(id: 1, areasInOrderOfPriority: [
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
    ]),
    lifeSatisfactionRatings: {
      'Test Life Area': LifeRatingResultModel(
        id: 1,
        subjectId: const SubjectIdModel(id: ''),
        wolArea: 'Test Life Area',
        rating: const IndividualSatisfactionRatingResultModel(
          id: 1,
          rating: 3,
          scale: DefaultRatingScaleModel(
              id: 1, ratingScaleName: '', minValue: 1, maxValue: 5, icon: null),
        ),
        createdWhen: DateTime.now(),
      ),
    },
    attemptedQuestions: false,
    journeyPath: null,
    journeyStartedAt: null,
    journeyStatus: null,
    latestMood: null,
  );
  const tAppRouteForUptoSatisfactionRatings =
      AppRouteModel(name: RouteName.hubScreen);
  final tHubStatusUptoTarget = HubStatusModel(
    id: 1,
    subjectInformation: const SubjectInformationModel(
      name: 'Test user',
      nickName: 'testyy',
      gender: null,
      subjectId: SubjectIdModel(id: ''),
      userID: '',
      deviceIndentifier: 'test_device_id',
    ),
    targetFocus: const TargetFocusListModel(id: 1, targetFocusList: [
      IssueModel(
          issueId: 1,
          focusName: 'Test_Focus',
          displayName: 'Test Focus',
          messageOnSelection: 'something!!!',
          issueIcon: null),
    ]),
    lifePriorities: const LifePrioritiesModel(id: 1, areasInOrderOfPriority: [
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
    ]),
    lifeSatisfactionRatings: {
      'Test Life Area': LifeRatingResultModel(
        id: 1,
        subjectId: const SubjectIdModel(id: ''),
        wolArea: 'Test Life Area',
        rating: const IndividualSatisfactionRatingResultModel(
          id: 1,
          rating: 3,
          scale: DefaultRatingScaleModel(
              id: 1, ratingScaleName: '', minValue: 1, maxValue: 5, icon: null),
        ),
        createdWhen: DateTime.now(),
      ),
    },
    attemptedQuestions: false,
    journeyPath: null,
    journeyStartedAt: null,
    journeyStatus: null,
    latestMood: null,
  );
  const tAppRouteForUptoTarget = AppRouteModel(name: RouteName.hubScreen);
  final tHubStatusUptoQuestionnaire = HubStatusModel(
    id: 1,
    subjectInformation: const SubjectInformationModel(
      name: 'Test user',
      nickName: 'testyy',
      gender: null,
      subjectId: SubjectIdModel(id: ''),
      userID: '',
      deviceIndentifier: 'test_device_id',
    ),
    targetFocus: const TargetFocusListModel(id: 1, targetFocusList: [
      IssueModel(
          issueId: 1,
          focusName: 'Test_Focus',
          displayName: 'Test Focus',
          messageOnSelection: 'something!!!',
          issueIcon: null),
    ]),
    lifePriorities: const LifePrioritiesModel(id: 1, areasInOrderOfPriority: [
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
    ]),
    lifeSatisfactionRatings: {
      'Test Life Area': LifeRatingResultModel(
        id: 1,
        subjectId: const SubjectIdModel(id: ''),
        wolArea: 'Test Life Area',
        rating: const IndividualSatisfactionRatingResultModel(
          id: 1,
          rating: 3,
          scale: DefaultRatingScaleModel(
              id: 1, ratingScaleName: '', minValue: 1, maxValue: 5, icon: null),
        ),
        createdWhen: DateTime.now(),
      ),
    },
    attemptedQuestions: true,
    journeyPath: null,
    journeyStartedAt: null,
    journeyStatus: null,
    latestMood: null,
  );
  const tAppRouteForUptoQuestionnaire =
      AppRouteModel(name: RouteName.hubScreen);
  final tHubStatusForOnboarded = HubStatusModel(
    id: 1,
    subjectInformation: const SubjectInformationModel(
      name: 'Test user',
      nickName: 'testyy',
      gender: null,
      subjectId: SubjectIdModel(id: ''),
      userID: '',
      deviceIndentifier: 'test_device_id',
    ),
    targetFocus: const TargetFocusListModel(id: 1, targetFocusList: [
      IssueModel(
          issueId: 1,
          focusName: 'Test_Focus',
          displayName: 'Test Focus',
          messageOnSelection: 'something!!!',
          issueIcon: null),
    ]),
    lifePriorities: const LifePrioritiesModel(id: 1, areasInOrderOfPriority: [
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
      'Test Life Area',
    ]),
    lifeSatisfactionRatings: {
      'Test Life Area': LifeRatingResultModel(
        id: 1,
        subjectId: const SubjectIdModel(id: ''),
        wolArea: 'Test Life Area',
        rating: const IndividualSatisfactionRatingResultModel(
          id: 1,
          rating: 3,
          scale: DefaultRatingScaleModel(
              id: 1, ratingScaleName: '', minValue: 1, maxValue: 5, icon: null),
        ),
        createdWhen: DateTime.now(),
      ),
    },
    attemptedQuestions: true,
    journeyPath: const JourneyModel(
      id: 1,
      title: 'TEST',
      subtitle: 'TEST',
      description: 'SSSS',
      icon: null,
      pathName: 'TEST_PATH',
    ),
    journeyStartedAt: DateTime.now(),
    journeyStatus: 'STARTED',
    latestMood: 'GOOD',
  );
  const tAppRouteForOnboarded =
      AppRouteModel(name: RouteName.onBoardingIncomplete);
  const tEmptyHub = HubStatusModel(
    id: null,
    subjectInformation: SubjectInformationModel(
        subjectId: SubjectIdModel(id: ''),
        userID: '',
        name: '',
        nickName: null,
        deviceIndentifier: 'xxx',
        gender: null),
    targetFocus: null,
    lifePriorities: null,
    lifeSatisfactionRatings: null,
    attemptedQuestions: false,
    journeyPath: null,
    journeyStartedAt: null,
    journeyStatus: null,
    latestMood: null,
  );

  group('DATA SOURCE', () {
    test(
        'If HubStatus has only nickname in it then return /rapport as Abandoned route',
        () async {
      //act
      final result = await localDataSourceImpl.getLastAbandonedPage(
        hubStatusModel: tHubStatusOnlyNickname,
      );
      //assert
      expect(result, tAppRouteForOnlyNickname);
    });
    test(
        'If HubStatus is filled upto mood then return /rapport as Abandoned route',
        () async {
      //act
      final result = await localDataSourceImpl.getLastAbandonedPage(
        hubStatusModel: tHubStatusUptoMood,
      );
      //assert
      expect(result, tAppRouteForUptoMood);
    });
    test(
        'If HubStatus has data untill priorities in it then return /hub as Abandoned route',
        () async {
      //act
      final result = await localDataSourceImpl.getLastAbandonedPage(
        hubStatusModel: tHubStatusUptoPriorities,
      );
      //assert
      expect(result, tAppRouteForUptoPriorities);
    });
    test(
        'If HubStatus has data untill ratings in it then return /hub as Abandoned route',
        () async {
      //act
      final result = await localDataSourceImpl.getLastAbandonedPage(
        hubStatusModel: tHubStatusUptoPriorities,
      );
      //assert
      expect(result, tAppRouteForUptoSatisfactionRatings);
    });
    test(
        'If HubStatus has data untill target in it then return /hub as Abandoned route',
        () async {
      //act
      final result = await localDataSourceImpl.getLastAbandonedPage(
        hubStatusModel: tHubStatusUptoTarget,
      );
      //assert
      expect(result, tAppRouteForUptoTarget);
    });
    test(
        'If HubStatus has data untill questionnaire in it then return /hub as Abandoned route',
        () async {
      //act
      final result = await localDataSourceImpl.getLastAbandonedPage(
        hubStatusModel: tHubStatusUptoQuestionnaire,
      );
      //assert
      expect(result, tAppRouteForUptoQuestionnaire);
    });
    test(
        'If HubStatus has all the needed data then return /onboardingIncomplete as Abandoned route',
        () async {
      //act
      final result = await localDataSourceImpl.getLastAbandonedPage(
        hubStatusModel: tHubStatusForOnboarded,
      );
      //assert
      expect(result, tAppRouteForOnboarded);
    });
    test(
        'If HubStatus has no data in it then return fallback-route should be returned as Abandoned route',
        () async {
      //act
      final result = await localDataSourceImpl.getLastAbandonedPage(
        hubStatusModel: tEmptyHub,
      );
      //assert
      expect(result, appFallbackRoute);
    });
  });
}
