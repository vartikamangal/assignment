import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/platform/instant.dart';
import 'subject-id.dart';

class MoodTracking extends Equatable {
  final SubjectId subjectId;
  final int id;
  String moodDuration;
  final String activityType;
  final String mood;
  final Instant createdWhen;
  MoodTracking({
    @required this.activityType,
    @required this.createdWhen,
    @required this.id,
    @required this.mood,
    @required this.moodDuration,
    @required this.subjectId,
  });
  @override
  List<Object> get props {
    return [
      subjectId,
      id,
      moodDuration,
      activityType,
      mood,
      createdWhen,
    ];
  }

  MoodTracking copyWith({
    SubjectId subjectId,
    int id,
    String moodDuration,
    String activityType,
    String mood,
    Instant createdWhen,
  }) {
    return MoodTracking(
      subjectId: subjectId ?? this.subjectId,
      id: id ?? this.id,
      moodDuration: moodDuration ?? this.moodDuration,
      activityType: activityType ?? this.activityType,
      mood: mood ?? this.mood,
      createdWhen: createdWhen ?? this.createdWhen,
    );
  }
}
