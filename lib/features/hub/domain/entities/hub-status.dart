import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:tatsam_app_experimental/features/hub/domain/entities/life-priority-list.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/life-rating-result.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/target-focus-list.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-information-model.dart';

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
