import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-category-model.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation-category.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';
import 'package:tatsam_app_experimental/features/home-management/data/repositories/add-weekly-category-service-impl.dart';
import 'package:tatsam_app_experimental/features/home-management/data/sources/add-weekly-category-remote-service.dart';
import 'add-weekly-category-service-impl_test.mocks.dart';

@GenerateMocks([AddWeeklyCategoryRemoteService, NetworkInfo])
void main() {
  MockAddWeeklyCategoryRemoteService? remoteService;
  MockNetworkInfo? networkInfo;
  late AddWeeklyCategoryServiceImpl serviceImpl;
  BaseRepository baseRepository;
  CallIfNetworkConnected callIfNetworkConnected;
  HandleException handleException;

  setUp(() {
    remoteService = MockAddWeeklyCategoryRemoteService();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
        callIfNetworkConnected: callIfNetworkConnected,
        handleException: handleException);
    serviceImpl = AddWeeklyCategoryServiceImpl(
        remoteService: remoteService, baseRepository: baseRepository);
  });

  const tWeekNumber = 1;
  final tRecommendationCategory =
      RecommendationCategoryModel.fromDomain(RecommendationCategory(
    id: 1,
    categoryName: 'categoryName',
    displayTitle: 'displayTitle',
    displaySubtitle: 'displaySubtitle',
    categoryDetailedDescription: 'categoryDetailedDescription',
    categoryShortDescription: 'categoryShortDescription',
    iconVO: ImageEntity(
        type: '',
        url: 'https://images.unsplash.com/photo-1547721064-da6cfb341d50'),
  ));

  const tUnit = unit;

  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : addWeeklyCategory', () {
      setUp(() {
        when(networkInfo!.isConnected).thenAnswer((_) async => true);
      });
      group('DEVICE ONLINE : addWeeklyCategory', body);
    });
  }

  //? Actual tests go here
  runTestsOnline(() {
    // test('should check if the device is online', () async {
    //   //arrange
    //   when(remoteService!.addWeeklyCategory(
    //       weekNumber: tWeekNumber, category: tRecommendationCategory))
    //       .thenAnswer((_) async => tUnit);
    //   //act
    //   await serviceImpl.addWeeklyCategory();
    //   //assert
    //   verify(networkInfo!.isConnected);
    // });
    // test(
    //     'should get basic profile details when coonection to remote data source is successfull',
    //     () async {
    //   //arrange
    //   when(remoteService!.addWeeklyCategory(
    //           weekNumber: tWeekNumber, category: tRecommendationCategory))
    //       .thenAnswer((_) async => tUnit);
    //   //act
    //   final result = await remoteService!.addWeeklyCategory(
    //       weekNumber: tWeekNumber, category: tRecommendationCategory);
    //   //assert
    //   verify(remoteService!.addWeeklyCategory(
    //       weekNumber: tWeekNumber, category: tRecommendationCategory));
    //   expect(result, tUnit);
    // });
    // test('should return ServerFailure when the call to remoteDataSource fails',
    //     () async {
    //   //arrange
    //   when(remoteService!.addWeeklyCategory(
    //           weekNumber: tWeekNumber, category: tRecommendationCategory))
    //       .thenThrow(ServerException());
    //   //act
    //   final result = await serviceImpl.addWeeklyCategory();
    //   //assert
    //   expect(result, Left(ServerFailure()));
    // });
  });
  test('DEVICE OFFLINE : addWeeklyCategory should return DeviceOfflineFailure',
      () async {
    when(networkInfo!.isConnected).thenAnswer((_) async => false);
    //act
    final result = await remoteService!.addWeeklyCategory(
        weekNumber: tWeekNumber, category: tRecommendationCategory);
    //assert
    expect(result, null);
  });
}
