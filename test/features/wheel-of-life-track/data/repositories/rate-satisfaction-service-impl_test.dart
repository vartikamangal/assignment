// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/life-area-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/rating-scale-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/satisfaction-rating-map-for-time-provision-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/models/satisfaction-ratings-model.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/repository/wheel-of-life-repository-impl.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/data/sources/wheel-of-life-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/rated-satisfaction-success.dart';
import 'rate-satisfaction-service-impl_test.mocks.dart';

@GenerateMocks([WheelOfLifeRemoteDataSource,NetworkInfo])

void main() {
  late MockWheelOfLifeRemoteDataSource? remoteService;
  MockNetworkInfo? networkInfo;
  late WheelOfLifeRepositoryImpl serviceImpl;
  HandleException handleException;
  CallIfNetworkConnected callIfNetworkConnected;
  BaseRepository baseRepository;

  setUp(() {
    remoteService = MockWheelOfLifeRemoteDataSource();
    networkInfo = MockNetworkInfo();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
      callIfNetworkConnected: callIfNetworkConnected,
      handleException: handleException,
    );
    serviceImpl = WheelOfLifeRepositoryImpl(
      remoteDataSource: remoteService,
      baseRepository: baseRepository,
    );
  });

  final tLifeAreaTimeProvisions = [
    SatisfactionRatingMapForTimeProvisionModel(
      rating: RatingScaleModel(
        min: 1,
        max: 5,
        ratingValue: 2,
        ratingScaleName: 'WOL_SATISFACTION_RATING',
      ),
      lifeArea: const LifeAreaModel(
        areaCode: "CAREER",
        name: "Career",
        description: "Your job, business and aspirations",
      ),
    ),
    SatisfactionRatingMapForTimeProvisionModel(
      rating: RatingScaleModel(
        min: 1,
        max: 5,
        ratingValue: 2,
        ratingScaleName: 'WOL_SATISFACTION_RATING',
      ),
      lifeArea: const LifeAreaModel(
        areaCode: "ROMANCE",
        name: "Romance",
        description: "Your job, business and aspirations",
      ),
    ),
    SatisfactionRatingMapForTimeProvisionModel(
      rating: RatingScaleModel(
        min: 1,
        max: 5,
        ratingValue: 2,
        ratingScaleName: 'WOL_SATISFACTION_RATING',
      ),
      lifeArea: const LifeAreaModel(
        areaCode: "PERSONAL_GROWTH",
        name: "PERSONAL_GROWTH",
        description: "Your job, business and aspirations",
      ),
    ),
    SatisfactionRatingMapForTimeProvisionModel(
      rating: RatingScaleModel(
        min: 1,
        max: 5,
        ratingValue: 2,
        ratingScaleName: 'WOL_SATISFACTION_RATING',
      ),
      lifeArea: const LifeAreaModel(
        areaCode: "FINANCES",
        name: "FINANCES",
        description: "Your job, business and aspirations",
      ),
    ),
    SatisfactionRatingMapForTimeProvisionModel(
      rating: RatingScaleModel(
        min: 1,
        max: 5,
        ratingValue: 2,
        ratingScaleName: 'WOL_SATISFACTION_RATING',
      ),
      lifeArea: const LifeAreaModel(
        areaCode: "HEALTH",
        name: "HEALTH",
        description: "Your job, business and aspirations",
      ),
    ),
    SatisfactionRatingMapForTimeProvisionModel(
      rating: RatingScaleModel(
        min: 1,
        max: 5,
        ratingValue: 2,
        ratingScaleName: 'WOL_SATISFACTION_RATING',
      ),
      lifeArea: const LifeAreaModel(
        areaCode: "FAMILY_AND_FRIENDS",
        name: "FAMILY_AND_FRIENDS",
        description: "Your job, business and aspirations",
      ),
    ),
    SatisfactionRatingMapForTimeProvisionModel(
      rating: RatingScaleModel(
        min: 1,
        max: 5,
        ratingValue: 2,
        ratingScaleName: 'WOL_SATISFACTION_RATING',
      ),
      lifeArea: const LifeAreaModel(
        areaCode: "FUN_AND_RECREATION",
        name: "FUN_AND_RECREATION",
        description: "Your job, business and aspirations",
      ),
    ),
    SatisfactionRatingMapForTimeProvisionModel(
      rating: RatingScaleModel(
        min: 1,
        max: 5,
        ratingValue: 2,
        ratingScaleName: 'WOL_SATISFACTION_RATING',
      ),
      lifeArea: const LifeAreaModel(
        areaCode: "PHYSICAL_ENVIRONMENT",
        name: "PHYSICAL_ENVIRONMENT",
        description: "Your job, business and aspirations",
      ),
    ),
  ];

  final tSatisfactionRatings = SatisfactionRatingsModel(
    satisfactionRatings: tLifeAreaTimeProvisions,
  );

  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : RateSatisfactionService', () {
      setUp(() {
        when(networkInfo!.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Callback body) {
    group('DEVICE OFFLINE : RateSatisfactionService', () {
      setUp(() {
        when(networkInfo!.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  runTestsOnline(() {
    // test('should check if the device is online', () async {
    //   //act
    //   await serviceImpl.rateSatisfactionService(
    //     satisfactionRatings: tSatisfactionRatings,
    //   );
    //   //assert
    //   verify(networkInfo!.isConnected);
    // });
    test(
        'should return SuccessRatedSatisfaction when the call to remote service is successfull',
        () async {
      //arrange
      when(remoteService!.rateSatisfaction(ratings: tSatisfactionRatings))
          .thenAnswer((realInvocation) async => SuccessRatedSatisfaction());
      //act
      final result = await serviceImpl.rateSatisfactionService(
          satisfactionRatings: tSatisfactionRatings);
      //assert
      verify(remoteService!.rateSatisfaction(ratings: tSatisfactionRatings));
      expect(result, Right(SuccessRatedSatisfaction()));
    });
    test('should return ServerFailure when the call to remote service fails',
        () async {
      //arrange
      when(remoteService!.rateSatisfaction(ratings: tSatisfactionRatings))
          .thenThrow(ServerException());
      //act
      final result = await serviceImpl.rateSatisfactionService(
          satisfactionRatings: tSatisfactionRatings);
      //assert
      verify(remoteService!.rateSatisfaction(ratings: tSatisfactionRatings));
      expect(result, Left(ServerFailure()));
    });
  });
  runTestsOffline(() {
    test('should return DeviceOfflineFailure', () async {
      //act
      final result = await serviceImpl.rateSatisfactionService(
          satisfactionRatings: tSatisfactionRatings);
      //assert
      verifyZeroInteractions(remoteService);
      expect(result, Left(DeviceOfflineFailure()));
    });
  });
}
