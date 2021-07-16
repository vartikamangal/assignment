import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/features/home-management/data/models/post-onboparding-action-model.dart';
import 'package:tatsam_app_experimental/features/home-management/domain/entities/post-onboarding-action.dart';

import '../../../../fixtures/fixture-reader.dart';

void main() {
  const tPostOnBoardingActionModel = PostOnboardingActionModel(
      actionId: 1,
      journeyId: 'journeyId',
      actionStatus: 'actionStatus',
      title: 'title',
      subtitle: 'subtitle',
      feedbackMood: 'feedbackMood',
      durationInMinutes: 1);
  group('Model PostOnboardingActionModel', () {
    test('should be a extended version of PostOnboardingAction', () async {
      //assert
      expect(tPostOnBoardingActionModel, isA<PostOnboardingAction>());
    });
  });
}
