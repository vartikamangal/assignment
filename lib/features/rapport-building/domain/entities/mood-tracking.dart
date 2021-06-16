// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'subject-id.dart';

class MoodTracking extends Equatable {
  final SubjectId subjectId;
  final int id;
  String moodDuration;
  final String activityType;
  final String mood;
  final DateTime createdWhen;
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
}
