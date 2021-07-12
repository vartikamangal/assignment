import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/common-input-feedback-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/save-feedback-local-service.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/persistence-consts.dart';
import 'save-feedback-local-service_test.mocks.dart';
import 'package:matcher/matcher.dart';

@GenerateMocks([Box])
void main() {
  late MockBox? localClient;
  late SaveFeedbackLocalServiceImpl serviceImpl;

  setUp(() {
    localClient = MockBox();
    serviceImpl = SaveFeedbackLocalServiceImpl(
      localClient: localClient!,
    );
  });

  const tCommonFeedback= CommonInputFeedbackModel(
    subjectId: "subjetcId",
    activityType: "activityType",
    textFeedback: "textFeedback",
    voiceNote: "voiceNote",
    timeOfCreation: "timeOfCreation",
  );

  group('DATA SOURCE : userOnboardingStatus', ()
  {
    test('should get user onboarding status from the service', () async {
      //arrange
      when(localClient!.put("boxKey", tCommonFeedback))
          .thenAnswer((_) async => unit);
      //act
      final result = await serviceImpl.setFeeling(subjetcId: "subjetcId",
          activityType: "activityType",
          textFeedback: "textFeedback",
          voiceNote: "voiceNote",
          timeOfCreation: "timeOfCreation",
          boxKey: "boxKey");
      expect(result, unit);
    });

    // test('should throw CacheException when cant retrive user path', () async {
    //   //arrange
    //   when(localClient!.put("boxKey", tCommonFeedback))
    //       .thenThrow(CacheException());
    //   //act
    //   final call = serviceImpl.setFeeling(
    //       subjetcId: "subjetcId",
    //       activityType: "activityType",
    //       textFeedback: "textFeedback",
    //       voiceNote: "voiceNote",
    //       timeOfCreation: "timeOfCreation",
    //       boxKey: "boxKey");
    //   // //assert
    //    expect(() => call, throwsA(const TypeMatcher<CacheException>()));
    // });
  });


}