import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/app-page-status/data/models/app-route-model.dart';
import 'package:tatsam_app_experimental/core/app-page-status/data/repository/app-page-status-repository-impl.dart';
import 'package:tatsam_app_experimental/core/app-page-status/data/sources/app-page-status-local-data-source.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/hub-status-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/life-priority-list-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/target-focus-list-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-id-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-information-model.dart';

class MockAppPageStatusLocalDataSource extends Mock
    implements AppPageStatusLocalDataSource {}

void main() {
  MockAppPageStatusLocalDataSource localDataSource;
  AppPageStatusRepositoryImpl repositoryImpl;

  setUp(() {
    localDataSource = MockAppPageStatusLocalDataSource();
    repositoryImpl = AppPageStatusRepositoryImpl(
      localDataSource: localDataSource,
    );
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
  );

  const tAppRouteModel = AppRouteModel(name: '/test-route');

  group('REPOSITORY: AppPageStatusRepository', () {
    test('should get the [AppRouteModel] with the help of localDataSource',
        () async {
      //arrange
      when(localDataSource.getLastAbandonedPage(
        hubStatusModel: anyNamed("hubStatusModel"),
      )).thenAnswer((_) async => tAppRouteModel);
      //act
      final result = await repositoryImpl.getLastAbandonedPage(
        hubStatusModel: tHubStatus,
      );
      //assert
      verify(localDataSource.getLastAbandonedPage(hubStatusModel: tHubStatus));
      expect(result, const Right(tAppRouteModel));
    });
    // test(
    //     'should return [AbandonedPageNotFoundFailure] when [AbandonedPageNotFoundException] occurs in localDataSource',
    //     () async {
    //   //arrange
    //   when(localDataSource.getLastAbandonedPage(
    //     hubStatusModel: anyNamed("hubStatusModel"),
    //   )).thenThrow(AbandonedPageNotFoundException());
    //   //act
    //   final result = await localDataSource.getLastAbandonedPage(
    //     hubStatusModel: tHubStatus,
    //   );
    //   //assert
    //   expect(
    //     result,
    //     equals(const Left(
    //       AbandonedPageNotFoundFailure(fallbackRoute: appFallbackRoute),
    //     )),
    //   );
    // });
  });
}
