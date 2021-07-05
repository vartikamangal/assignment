// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

// Project imports:
import '../../../../core/cache-manager/data/models/common-input-feedback-model.dart';
import '../../../error/exceptions.dart';

abstract class SaveFeedbackLocalService {
  Future<Unit> setFeeling({
    required String? subjetcId,
    required String? activityType,
    required String? textFeedback,
    required String? voiceNote,
    required String? timeOfCreation,
    required String? boxKey,
  });
}

class SaveFeedbackLocalServiceImpl implements SaveFeedbackLocalService {
  final Box localClient;

  SaveFeedbackLocalServiceImpl({required this.localClient});
  @override
  Future<Unit> setFeeling({
    required String? subjetcId,
    required String? activityType,
    required String? textFeedback,
    required String? voiceNote,
    required String? timeOfCreation,
    required String? boxKey,
  }) async {
    try {
      final feedback = jsonEncode(
        CommonInputFeedbackModel(
          subjectId: subjetcId,
          activityType: activityType,
          textFeedback: textFeedback,
          voiceNote: voiceNote,
          timeOfCreation: timeOfCreation,
        ).toJson(),
      );
      await localClient.put(boxKey, feedback);
      log('feedback persisted');
      return unit;
    } catch (e) {
      throw CacheException();
    }
  }
}
