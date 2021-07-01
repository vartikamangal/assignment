// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/app-page-status/data/sources/app-page-status-local-data-source.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/data/models/journey-model.dart';

// Project imports:
import '../../../rapport-building/data/models/subject-information-model.dart';
import '../../domain/entities/hub-status.dart';
import 'life-priority-list-model.dart';
import 'life-rating-result-model.dart';
import 'target-focus-list-model.dart';

class HubStatusModel extends HubStatus {
  const HubStatusModel({
    @required int id,
    @required SubjectInformationModel subjectInformation,
    @required TargetFocusListModel targetFocus,
    @required LifePrioritiesModel lifePriorities,
    @required Map<String, LifeRatingResultModel> lifeSatisfactionRatings,
    @required bool attemptedQuestions,
    @required JourneyModel journeyPath,
    @required DateTime journeyStartedAt,
    @required String journeyStatus,
    @required String latestMood,
  }) : super(
          subjectInformation: subjectInformation,
          id: id,
          lifePriorities: lifePriorities,
          lifeSatisfactionRatings: lifeSatisfactionRatings,
          targetFocus: targetFocus,
          attemptedQuestions: attemptedQuestions,
          journey: journeyPath,
          journeyStartedAt: journeyStartedAt,
          userMood: latestMood,
          journeyStatus: journeyStatus,
        );

  factory HubStatusModel.fromJson(Map<String, dynamic> jsonMap) {
    final rawLifeRatings = jsonMap['lifeSatisfactionRatings'] == null
        ? jsonMap['lifeSatisfactionRatings']
        : jsonMap['lifeSatisfactionRatings']['lifeSatisfactionRatings']
            as Map<String, dynamic>;
    final Map<String, LifeRatingResultModel> parsedLifeRatings = {};
    // Transforms the LifeRatings fetched from API as per our needs
    // ignore: avoid_function_literals_in_foreach_calls
    try {
      rawLifeRatings.keys.forEach((lifeAreaName) {
        parsedLifeRatings.putIfAbsent(
          lifeAreaName as String,
          () => LifeRatingResultModel.fromJson(
            rawLifeRatings[lifeAreaName] as Map<String, dynamic>,
          ),
        );
      });
    } catch (e) {
      log('seems like a new user');
    }
    return HubStatusModel(
      id: jsonMap['id'] as int,
      subjectInformation: SubjectInformationModel.fromJson(
        jsonMap['subjectInformation'] as Map<String, dynamic>,
      ),
      targetFocus: TargetFocusListModel.fromJson(
        jsonMap['targetFocus'] as Map<String, dynamic>,
      ),
      lifePriorities: LifePrioritiesModel.fromJson(
        jsonMap['lifePriorities'] as Map<String, dynamic>,
      ),
      lifeSatisfactionRatings:
          jsonMap['lifeSatisfactionRatings'] == null ? null : parsedLifeRatings,
      attemptedQuestions: jsonMap['attemptedQuestions'] as bool,
      journeyPath: jsonMap["journeyPath"] == null
          ? null
          : JourneyModel.fromJson(
              jsonMap["journeyPath"] as Map<String, dynamic>),
      journeyStartedAt: jsonMap['journeyStartedAt'] == null
          ? null
          : DateTime.parse(jsonMap['journeyStartedAt'] as String),
      journeyStatus: jsonMap["journeyStatus"] == null
          ? null
          : jsonMap["journeyStatus"] as String,
      latestMood: jsonMap["latestMood"] == null
          ? null
          : (jsonMap["latestMood"] as Map<String, dynamic>)["mood"] as String,
    );
  }

  AbandonedPageStates recentlyAbandonedPage() {
    if (journey != null && journeyStatus == "STARTED") {
      return AbandonedPageStates.ONBOARDED;
    }
    // else if (journey == null && journeyStatus == "STARTED") {
    //   return AbandonedPageStates.TRAVELLER_CREATED;
    // }
    else if (attemptedQuestions) {
      return AbandonedPageStates.UNTILL_QUESTIONNAIRE;
    } else if (targetFocus != null) {
      return AbandonedPageStates.UNTILL_TARGETS;
    } else if (lifeSatisfactionRatings != null) {
      return AbandonedPageStates.UNTILL_RATINGS;
    } else if (lifePriorities != null) {
      return AbandonedPageStates.UNTILL_PRIORIITIES;
    } else if (userMood != null) {
      ///If user has entered mood on rapport screen
      //TODO First figure out the deep-linking thing!!
      return AbandonedPageStates.MOOD_ENTERED;
    } else if (subjectInformation.nickName != null) {
      return AbandonedPageStates.ONLY_NICKNAME;
    } else {
      return AbandonedPageStates.FALLBACK;
    }
  }
}
