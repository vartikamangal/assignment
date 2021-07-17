import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/activity-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/guided-activity-recommendation-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-category-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/tag-model.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/guided-activity-recommendation.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/models/activity-step-model.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';
import 'package:tatsam_app_experimental/features/home-management/data/repositories/get-recommendations-repository-impl.dart';
import 'package:tatsam_app_experimental/features/home-management/data/sources/get-recommendations-by-action-time-remote-data-source.dart';

import 'get-recommendations-repository-impl_test.mocks.dart';

@GenerateMocks([GetRecommendationsByActionTimeRemoteDataSource, NetworkInfo])
void main() {
  late MockGetRecommendationsByActionTimeRemoteDataSource? remoteDataSource;
  MockNetworkInfo? networkInfo;
  late GetRecommendationsByActionTimeRepositoryRepositoryImpl
      repositoryRepositoryImpl;
  CallIfNetworkConnected callIfNetworkConnected;
  HandleException handleException;
  BaseRepository baseRepository;

  setUp(() {
    remoteDataSource = MockGetRecommendationsByActionTimeRemoteDataSource();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
        callIfNetworkConnected: callIfNetworkConnected,
        handleException: handleException);
    repositoryRepositoryImpl =
        GetRecommendationsByActionTimeRepositoryRepositoryImpl(
            remoteDataSource: remoteDataSource, baseRepository: baseRepository);
  });

  const tActionTime = '';
  // const tRecommendationCategoryModel = RecommendationCategoryModel(
  //     id: 1,
  //     categoryName: '',
  //     displayTitle: '',
  //     displaySubtitle: '',
  //     categoryDetailedDescription: '',
  //     categoryShortDescription: '',
  //     iconVO: null);

  /*const tRecommendationStepModel = [
    RecommendationStepModel(
        id: 1,
        stepTitle: 'stepTitle',
        stepHelp: 'stepHelp',
        stepName: 'stepName',
        stepSequence: 1,
        iconVO: '',
        templateName: 'templateName',
        stepContent: 'stepContent')
  ];*/

  // const tTagModel = [
  //   TagModel(
  //       name: 'name',
  //       tagCategory: 'tagCategory',
  //       displayName: 'displayName',
  //       parentName: 'parentName')
  // ];

  final tActivityRecommendationModel = [
    GuidedActivityRecommendationModel.fromDomain(GuidedActivityRecommendation(
        id: 78778,
        title: 'title',
        subtitle: 'subtitle',
        icon: ImageEntity(
            type: '',
            url: 'https://images.unsplash.com/photo-1547721064-da6cfb341d50'),
        helpContent: '',
        dayNumber: null,
        description: 'welcome to the activity',
        recommendationList: []))
  ];
  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : getRecommendations()', () {
      setUp(() {
        when(networkInfo!.isConnected).thenAnswer((_) async => true);
      });
      group('DEVICE ONLINE : getRecommendations()', body);
    });
  }

  //? Actual tests go here
  runTestsOnline(() {
    test(
        'should get recommendation when coonection to remote data source is successfull',
        () async {
      //arrange
      when(remoteDataSource!.getRecommendations(actionTime: tActionTime))
          .thenAnswer((_) async => <ActivityModel>[]);
      //act
      final result =
          await remoteDataSource!.getRecommendations(actionTime: tActionTime);
      //assert
      verify(remoteDataSource!.getRecommendations(actionTime: tActionTime));
      expect(result, tActivityRecommendationModel);
    });
    // test('should return ServerFailure when the call to remoteDataSource fails',
    //     () async {
    //   //arrange
    //   when(remoteDataSource!.getRecommendations(actionTime: tActionTime))
    //       .thenThrow(ServerException());
    //   //act
    //   final result = await repositoryRepositoryImpl.getRecommendations();
    //   //assert
    //   expect(result, Left(ServerFailure()));
    // });
  });
}
