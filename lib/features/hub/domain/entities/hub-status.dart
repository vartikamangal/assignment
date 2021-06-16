// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../rapport-building/data/models/subject-information-model.dart';
import 'life-priority-list.dart';
import 'life-rating-result.dart';
import 'target-focus-list.dart';

//! This is the main entity connecting all the other hub entities
class HubStatus extends Equatable {
  final int id;
  final SubjectInformationModel subjectInformation;
  final TargetFocusList targetFocus;
  final LifePriorities lifePriorities;
  final Map<String, LifeRatingResult> lifeSatisfactionRatings;
  final bool attemptedQuestions;
  const HubStatus({
    @required this.id,
    @required this.subjectInformation,
    @required this.targetFocus,
    @required this.lifePriorities,
    @required this.lifeSatisfactionRatings,
    @required this.attemptedQuestions,
  });
  @override
  List<Object> get props {
    return [
      id,
      subjectInformation,
      targetFocus,
      lifePriorities,
      lifeSatisfactionRatings,
    ];
  }

  @override
  bool get stringify => true;

  HubStatus copyWith({
    int id,
    SubjectInformationModel subjectInformation,
    TargetFocusList targetFocus,
    LifePriorities lifePriorities,
    Map<String, LifeRatingResult> lifeSatisfactionRatings,
    bool attemptedQuestions,
  }) {
    return HubStatus(
      id: id ?? this.id,
      subjectInformation: subjectInformation ?? this.subjectInformation,
      targetFocus: targetFocus ?? this.targetFocus,
      lifePriorities: lifePriorities ?? this.lifePriorities,
      lifeSatisfactionRatings:
          lifeSatisfactionRatings ?? this.lifeSatisfactionRatings,
      attemptedQuestions: attemptedQuestions ?? this.attemptedQuestions,
    );
  }
}
