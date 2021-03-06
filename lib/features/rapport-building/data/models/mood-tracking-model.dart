// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import '../../domain/entities/mood-tracking.dart';
import '../../domain/entities/subject-id.dart';
import 'subject-id-model.dart';

// ignore: must_be_immutable
class MoodTrackingModel extends MoodTracking {
  MoodTrackingModel({
    @required SubjectId subjectId,
    @required int id,
    @required String moodDuration,
    @required String activityType,
    @required String mood,
    @required DateTime createdWhen,
  }) : super(
          subjectId: subjectId,
          moodDuration: moodDuration,
          activityType: activityType,
          id: id,
          mood: mood,
          createdWhen: createdWhen,
        );

  factory MoodTrackingModel.fromJson(Map<String, dynamic> jsonMap) {
    return MoodTrackingModel(
      subjectId: SubjectIdModel.fromJson(
        jsonMap: jsonMap['subjectId'] as Map<String, dynamic>,
      ),
      id: jsonMap['id'] as int,
      moodDuration: jsonMap['moodDuration'] as String,
      activityType: jsonMap['activityType'] as String,
      mood: jsonMap['mood'] as String,
      createdWhen: DateTime.parse(
        jsonMap['createdWhen'] as String,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "subjectId": (subjectId as SubjectIdModel).toJson(),
      "id": id,
      "activityType": activityType,
      "moodDuration": moodDuration,
      "mood": mood,
    };
  }
}
