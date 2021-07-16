import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-category-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/repositories/get-all-recommendation-categories-repository-impl.dart';
import 'package:tatsam_app_experimental/core/activity/data/sources/get-all-recommendation-categories-remote-data-source.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';
import 'get-all-recommendation-category-repository-impl_test.mocks.dart';

@GenerateMocks([GetAllRecommendationCategoriesRemoteDataSource, NetworkInfo])
void main() {
  GetAllRecommendationCategoriesRemoteDataSource? remoteDataSource;
  MockNetworkInfo? networkInfo;
  late GetAllRecommendationCategoriesRepositoryImpl repositoryImpl;
  HandleException handleException;
  CallIfNetworkConnected callIfNetworkConnected;
  BaseRepository baseRepository;

  setUp(() {
    remoteDataSource = MockGetAllRecommendationCategoriesRemoteDataSource();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
      callIfNetworkConnected: callIfNetworkConnected,
      handleException: handleException,
    );
    repositoryImpl = GetAllRecommendationCategoriesRepositoryImpl(
      remoteDataSource: remoteDataSource,
      baseRepository: baseRepository,
    );
  });

 /* const tRecommendationCategory = <RecommendationCategoryModel>[
    RecommendationCategoryModel(
        id: 2,
        categoryName: "MENTAL",
        displayTitle: "Mental",
        displaySubtitle: "Focus on your mind",
        categoryDetailedDescription: "This is mental category",
        categoryShortDescription: "Focus on your mind",
        iconVO: '')
  ];*/

  void runTestOnline(Callback body) {
    setUp(() {
      when(networkInfo!.isConnected).thenAnswer((_) async => true);
    });
    group('DEVICE ONLINE : getAllCategories', body);
  }

  //! Actual tests go here
  runTestOnline(() {
    test('should check if the device is online', () async {
      //arrange
      //arrange
      when(remoteDataSource!.getAllCategories()).thenThrow(ServerException());
      //act
      await repositoryImpl.getAllCategories();
      //assert
      verify(networkInfo!.isConnected);
    });
    // test(
    //     'should return a List<InstReliefArea> when call to remote data source is successfull',
    //     () async {
    //   //arrange
    //   when(remoteDataSource!.getAllCategories())
    //       .thenAnswer((_) async => tRecommendationCategory);
    //   //act
    //   final result = await repositoryImpl.getAllCategories();
    //   //assert
    //   verify(remoteDataSource!.getAllCategories());
    //   expect(result, const Right(tRecommendationCategory));
    // });
    test(
        'should return a ServerFailure when call to remoteDataSource is unsuccessfull.',
        () async {
      //arrange
      when(remoteDataSource!.getAllCategories()).thenThrow(ServerException());
      //act
      final result = await repositoryImpl.getAllCategories();
      //assert
      expect(result, Left(ServerFailure()));
    });
  });
  test('DEVICE OFFLINE : GetAllCategory should return DeviceOfflineFailure',
      () async {
    when(networkInfo!.isConnected).thenAnswer((_) async => false);
    //act
    final result = await repositoryImpl.getAllCategories();
    //assert
    expect(result, Left(DeviceOfflineFailure()));
  });
}
