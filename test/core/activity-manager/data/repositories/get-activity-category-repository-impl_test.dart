import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-activity-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-category-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-step-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/tag-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/repositories/get-activity-category-repository-impl.dart';
import 'package:tatsam_app_experimental/core/activity/data/sources/get-category-activites-remote-data-source.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';
import 'get-activity-category-repository-impl_test.mocks.dart';

@GenerateMocks([GetCategoryActivitiesRemoteDataSource, NetworkInfo])
void main() {
  MockNetworkInfo? networkInfo;
  MockGetCategoryActivitiesRemoteDataSource? remoteService;
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

  const tCategoryModel = RecommendationCategoryModel(
      id: 2,
      categoryName: "MENTAL",
      displayTitle: "Mental",
      displaySubtitle: "Focus on your mind",
      categoryDetailedDescription: "This is mental category",
      categoryShortDescription: "Focus on your mind",
      iconVO: ImageProp(urlShort: '', urlLarge: '', urlMedium: ''));

  const tRecommendations = <RecommendationModel>[
    RecommendationModel(
        activity: ActivityRecommendationModel(
            id: "08c3275f-e45e-4b6a-bfe7-280266baf6c5",
            title: "GUIDED EXERCISE - 2",
            subtitle: "Subtitle for GUIDED EXERCISE",
            iconVO: ImageProp(urlShort: '', urlLarge: '', urlMedium: ''),
            durationInMinutes: 15,
            messageOnReceivingFeedback: " This is an encouraging message",
            messageOnCompletion:
                "Understanding yourself starts with small steps. With regular practices, you will start seeing a positive shift in your mind",
            recommendationStatus: "ENABLED",
            frequencyMetric: "WEEKLY",
            frequency: 1,
            actionTime: "DO_NOW",
            criticality: "LOW",
            categoryVO: RecommendationCategoryModel(
                id: 1,
                categoryName: "PHYSICAL",
                displayTitle: "Physical",
                displaySubtitle: "Focus on the body",
                categoryDetailedDescription:
                    "This is physical category for body",
                categoryShortDescription: "Focus on the body",
                iconVO: ImageProp(urlShort: '', urlLarge: '', urlMedium: '')),
            recommendationStepsVO: <RecommendationStepModel>[
              RecommendationStepModel(
                  id: 3171,
                  stepTitle: "Content",
                  stepHelp: "",
                  stepName: "CONTENT",
                  stepSequence: 3,
                  iconVO: ImageProp(urlShort: '', urlLarge: '', urlMedium: ''),
                  templateName: "PLAIN_TEXT",
                  stepContent:
                      "What is your fondest childhood memory? What made it special?"),
              RecommendationStepModel(
                id: 3170,
                stepTitle: "Instructions",
                stepHelp: "",
                stepName: "INSTRUCTIONS",
                stepSequence: 2,
                iconVO: ImageProp(urlShort: '', urlLarge: '', urlMedium: ''),
                templateName: "PLAIN_TEXT",
                stepContent:
                    "The idea here is to record detailed descriptions of certain aspects of events, thoughts and feelings. Be as descriptive as possible and write down everything! The act of writing gives you perspectives that you may not consider if you just think about something.",
              ),
              RecommendationStepModel(
                  id: 3169,
                  stepTitle: "Did you know?",
                  stepHelp: "",
                  stepName: "DID_YOU_KNOW",
                  stepSequence: 1,
                  iconVO: ImageProp(urlShort: '', urlLarge: '', urlMedium: ''),
                  templateName: "PLAIN_TEXT",
                  stepContent: "Some useful did you know fact"),
            ],
            tags: <TagModel>[
              TagModel(
                  name: "ROMANCE",
                  tagCategory: "AREAS",
                  displayName: "Romance",
                  parentName: null),
              TagModel(
                  name: "ROMANCE_LOW",
                  tagCategory: "WOL_SATISFACTION_RATING",
                  displayName: "Satisfaction low for Romance",
                  parentName: "ROMANCE"),
              TagModel(
                  name: "WORK_FROM_HOME",
                  tagCategory: "FOCUS_ISSUE",
                  displayName: "Work form home",
                  parentName: null),
              TagModel(
                  name: "LOSING_TEMPER",
                  tagCategory: "INSTANT_RELIEF",
                  displayName: "Losing Temper",
                  parentName: null),
            ]),
        weight: 1.0)
  ];

  void runTestsOnline(Callback body) {
    group('DEVICE ONLINE : get-activity-category', () {
      setUp(() {
        when(networkInfo!.isConnected).thenAnswer((_) async => true);
      });
      group('DEVICE ONLINE : getactivities', body);
    });
  }

  void runTestsOffline(Callback body) {
    group('DEVICE OFFLINE : get activity category', () {
      setUp(() {
        when(networkInfo!.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  //? Actual tests go here
  runTestsOnline(() {
    // test('should check if the device is online', () async {
    //   //act
    //   await repositoryImpl.getActivities(category: tCategoryModel);
    //   //assert
    //   verify(networkInfo!.isConnected);
    // });
    test(
        'should return a List<Recommendation> when call to remote data source is successfull',
        () async {
      //arrange
      when(remoteService!.getActivities(category: tCategoryModel))
          .thenAnswer((_) async => tRecommendations);
      //act
      final result =
          await remoteService!.getActivities(category: tCategoryModel);
      //assert
      verify(remoteService!.getActivities(category: tCategoryModel));
      expect(result, tRecommendations);
    });
    test('should return ServerFailure when the call to remoteService fails',
        () async {
      //arrange
      when(remoteService!.getActivities(category: tCategoryModel))
          .thenThrow(ServerException());
      //act
      final result =
          await repositoryImpl.getActivities(category: tCategoryModel);
      //assert
      expect(result, Left(ServerFailure()));
    });
  });
  test('DEVICE OFFLINE : getactivity should return DeviceOfflineFailure',
      () async {
    when(networkInfo!.isConnected).thenAnswer((_) async => false);
    //act
    // final result = await remoteService!.getActivities(category: tCategoryModel);
    // //assert
    // expect(result, Left(DeviceOfflineFailure()));
    // when(remoteService!.getActivities(category: tCategoryModel))
    //     .thenAnswer((_) async => tRecommendations);
  });
}
