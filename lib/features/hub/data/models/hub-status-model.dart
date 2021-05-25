import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/life-priority-list-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/life-rating-result-model.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/target-focus-list-model.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/hub-status.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-information-model.dart';

class HubStatusModel extends HubStatus {
  const HubStatusModel({
    @required int id,
    @required SubjectInformationModel subjectInformation,
    @required TargetFocusListModel targetFocus,
    @required LifePrioritiesModel lifePriorities,
    @required Map<String, LifeRatingResultModel> lifeSatisfactionRatings,
    @required bool attemptedQuestions,
  }) : super(
          subjectInformation: subjectInformation,
          id: id,
          lifePriorities: lifePriorities,
          lifeSatisfactionRatings: lifeSatisfactionRatings,
          targetFocus: targetFocus,
          attemptedQuestions: attemptedQuestions,
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
    );
  }
}
