// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'mood.dart';
import 'subject-id.dart';

class SubjectMood extends Equatable {
  final SubjectId subjectId;
  final Mood mood;
  final DateTime when;

  const SubjectMood({
    @required this.subjectId,
    @required this.mood,
    @required this.when,
  });

  @override
  List<Object> get props => [subjectId, mood, when];
}
