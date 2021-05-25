import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/platform/instant.dart';
import 'mood.dart';
import 'subject-id.dart';

class SubjectMood extends Equatable {
  final SubjectId subjectId;
  final Mood mood;
  final Instant when;

  const SubjectMood({
    @required this.subjectId,
    @required this.mood,
    @required this.when,
  });

  @override
  List<Object> get props => [subjectId, mood, when];
}
