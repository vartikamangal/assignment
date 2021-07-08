// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Flutter imports:

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/activity/data/models/activity-status-model.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/recommendation-input-model.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/persistence-consts.dart';

abstract class PersistRecommendationFeedbackLocalService {
  Future<Unit> persistFeedback({
    required ActivityStatusModel? activityStatusModel,
    required String? textInput,
    required String? voiceNoteInput,
  });
  Future<List<RecommendationInputModel>> getPersistedFeedbacks();
}

class PersistRecommendationFeedbackLocalServiceImpl
    implements PersistRecommendationFeedbackLocalService {
  final Box? box;

  PersistRecommendationFeedbackLocalServiceImpl({
    required this.box,
  });
  @override
  Future<Unit> persistFeedback({
    ActivityStatusModel? activityStatusModel,
    String? textInput,
    String? voiceNoteInput,
  }) async {
    try {
      /// This source firstly fetches old instances of preexisting persisted feedabacks
      /// Then merges the current feedback with old ones, and again persists them
      /// This var hold old feedbacks(if any)
      final List<String> oldCachedFeedbacks = _getOldCachedFeedbacks(
        box: box!,
      );

      /// Our fresh new feedback prepared for caching
      final recommendationInput = jsonEncode(
        RecommendationInputModel(
          recommendationId: activityStatusModel!.recommendationId,
          actionId: activityStatusModel.id.toString(),
          journeyId: activityStatusModel.journeyId,
          textFeedback: textInput,
          voiceNote: voiceNoteInput,
          timeOfCreation: DateTime.now().toString(),
        ).toJson(),
      );

      /// Added to the old list
      oldCachedFeedbacks.add(recommendationInput);

      /// List of feedbacks updated
      //! Keep a note that once it is sent to server, remove it from here {CONSULT}
      await box!.put(
        PersistenceConst.RECOMMENDATION_INPUTS,
        jsonEncode(
          oldCachedFeedbacks,
        ),
      );
      return unit;
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }

  /// If anyprecached feedabacks are found, return the List<String{Formatted with jsonEncode}> else returns []
  List<String> _getOldCachedFeedbacks({
    required Box box,
  }) {
    try {
      final oldUnParsedFeedbacks = box.get(
        PersistenceConst.RECOMMENDATION_INPUTS,
      );
      return (jsonDecode(oldUnParsedFeedbacks as String) as List)
          .map(
            (feedbackJsonObject) => feedbackJsonObject.toString(),
          )
          .toList();
    } catch (e) {
      log('Seems like saving something for the first time.');
      return [];
    }
  }

  @override
  Future<List<RecommendationInputModel>> getPersistedFeedbacks() async {
    try {
      final result = await box!.get(
        PersistenceConst.RECOMMENDATION_INPUTS,
      ) as String?;
      if (result != null) {
        /// valid for case if the any persisted activities are found
        return (jsonDecode(result) as List)
            .map(
              (log) => RecommendationInputModel.fromJson(
                jsonDecode(log as String) as Map<String, dynamic>,
              ),
            )
            .toList();
      } else {
        /// valid for case if the user didn't completed any activity yet
        return [];
      }
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }
}
