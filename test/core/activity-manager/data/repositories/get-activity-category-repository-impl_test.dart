import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-category-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/tag-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/repositories/get-activity-category-repository-impl.dart';
import 'package:tatsam_app_experimental/core/activity/data/sources/get-category-activites-remote-data-source.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation-category.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/tag.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/entities/activity-step.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';

import 'get-activity-category-repository-impl_test.mocks.dart';

@GenerateMocks([GetCategoryActivitiesRemoteDataSource, NetworkInfo])
void main() {
  late MockNetworkInfo networkInfo;
  late MockGetCategoryActivitiesRemoteDataSource remoteService;
  late GetCategoryActivitiesRepositoryImpl repositoryImpl;
  HandleException handleException;
  CallIfNetworkConnected callIfNetworkConnected;
  BaseRepository baseRepository;

  setUp(() {
    networkInfo = MockNetworkInfo();
    remoteService = MockGetCategoryActivitiesRemoteDataSource();
    callIfNetworkConnected = CallIfNetworkConnected(networkInfo: networkInfo);
    handleException = HandleException();
    baseRepository = BaseRepository(
      callIfNetworkConnected: callIfNetworkConnected,
      handleException: handleException,
    );
    repositoryImpl = GetCategoryActivitiesRepositoryImpl(
        remoteDataSource: remoteService, baseRepository: baseRepository);
  });

  final tRecommendationCategory = RecommendationCategory(
    id: 2,
    categoryName: "MENTAL",
    displayTitle: "Mental",
    displaySubtitle: "Focus on your mind",
    categoryDetailedDescription: "This is mental category",
    categoryShortDescription: "Focus on your mind",
    iconVO: ImageEntity(
        type: 'png',
        url: 'https://images.unsplash.com/photo-1547721064-da6cfb341d50'),
  );

  final tRecommendations = [
    RecommendationModel.fromDomain(Recommendation(
        activity: Activity(
            id: "08c3275f-e45e-4b6a-bfe7-280266baf6c5",
            title: "GUIDED EXERCISE - 2",
            subtitle: "Subtitle for GUIDED EXERCISE",
            iconVO: ImageEntity(
                type: '',
                url:
                'https://images.unsplash.com/photo-1547721064-da6cfb341d50'),
            durationInMinutes: 15,
            messageOnReceivingFeedback: " This is an encouraging message",
            messageOnCompletion:
            "Understanding yourself starts with small steps. With regular practices, you will start seeing a positive shift in your mind",
            recommendationStatus: "ENABLED",
            frequencyMetric: "WEEKLY",
            frequency: 1,
            actionTime: "DO_NOW",
            criticality: "LOW",
            categoryVO: RecommendationCategory(
                id: 1,
                categoryName: "PHYSICAL",
                displayTitle: "Physical",
                displaySubtitle: "Focus on the body",
                categoryDetailedDescription:
                "This is physical category for body",
                categoryShortDescription: "Focus on the body",
                iconVO: ImageEntity(
                    type: '',
                    url:
                    'https://images.unsplash.com/photo-1547721064-da6cfb341d50')),
            tags: <Tag>[
              Tag(
                  name: "ROMANCE",
                  tagCategory: "AREAS",
                  displayName: "Romance",
                  parentName: null),
              Tag(
                  name: "ROMANCE_LOW",
                  tagCategory: "WOL_SATISFACTION_RATING",
                  displayName: "Satisfaction low for Romance",
                  parentName: "ROMANCE"),
              Tag(
                  name: "WORK_FROM_HOME",
                  tagCategory: "FOCUS_ISSUE",
                  displayName: "Work form home",
                  parentName: null),
              Tag(
                  name: "LOSING_TEMPER",
                  tagCategory: "INSTANT_RELIEF",
                  displayName: "Losing Temper",
                  parentName: null),
            ],
            activitySteps: []),
        weight: 1.0))
  ];

  final tRecommendationCategoryModel =
  RecommendationCategoryModel.fromDomain(RecommendationCategory(
    id: 2,
    categoryName: "MENTAL",
    displayTitle: "Mental",
    displaySubtitle: "Focus on your mind",
    categoryDetailedDescription: "This is mental category",
    categoryShortDescription: "Focus on your mind",
    iconVO: ImageEntity(
        type: 'png',
        url: 'https://images.unsplash.com/photo-1547721064-da6cfb341d50'),
  ));

  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : get-activity-category', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      group('DEVICE ONLINE : getactivities', body);
    });
  }

  void runTestsOffline(Callback body) {
    group('DEVICE OFFLINE : get activity category', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  //? Actual tests go here
  runTestsOnline(() {
    // test('should check if the device is online', () async {
    //   when(remoteService.getActivities(category: tRecommendationCategoryModel))
    //       .thenAnswer((_) async => tRecommendations);
    //   //act
    //   final result = await remoteService.getActivities(
    //       category: tRecommendationCategoryModel);
    //   //assert
    //   verify(networkInfo.isConnected);
    // });
    test(
        'should return a List<Recommendation> when call to remote data source is successfull',
            () async {
          //arrange
          when(remoteService.getActivities(category: tRecommendationCategoryModel))
              .thenAnswer((_) async => tRecommendations);
          //act
          final result = await remoteService.getActivities(
              category: tRecommendationCategoryModel);
          //assert
          verify(
              remoteService.getActivities(category: tRecommendationCategoryModel));
          expect(result, tRecommendations);
        });
  //   test('should return ServerFailure when the call to remoteService fails',
  //           () async {
  //         //arrange
  //         when(remoteService.getActivities(category: tRecommendationCategoryModel))
  //             .thenThrow(ServerException());
  //         //act
  //         final result =
  //         await repositoryImpl.getActivities(category: tRecommendationCategory);
  //         //assert
  //         expect(result, Left(ServerFailure()));
  //       });
  // });
  // test('DEVICE OFFLINE : getactivity should return DeviceOfflineFailure',
  //         () async {
  //       when(networkInfo.isConnected).thenAnswer((_) async => false);
  //       //act
  //       final result = await remoteService.getActivities(
  //           category: tRecommendationCategoryModel);
  //       //assert
  //       expect(result, Left(DeviceOfflineFailure()));
       });
}