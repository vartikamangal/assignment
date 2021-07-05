// Flutter imports:
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
// Package imports:
import 'package:tatsam_app_experimental/features/what-path-to-choose/domain/entites/journey.dart';

// Project imports:
import '../../../rapport-building/data/models/subject-information-model.dart';
import 'life-priority-list.dart';
import 'life-rating-result.dart';
import 'target-focus-list.dart';

//! This is the main entity connecting all the other hub entities
class HubStatus extends Equatable {
  final int? id;
  final SubjectInformationModel subjectInformation;
  final TargetFocusList? targetFocus;
  final LifePriorities? lifePriorities;
  final Map<String, LifeRatingResult>? lifeSatisfactionRatings;
  final bool? attemptedQuestions;
  final Journey? journey;
  final DateTime? journeyStartedAt;
  final String? journeyStatus;
  final String? userMood;
  const HubStatus({
    required this.id,
    required this.subjectInformation,
    required this.targetFocus,
    required this.lifePriorities,
    required this.lifeSatisfactionRatings,
    required this.attemptedQuestions,
    required this.journey,
    required this.journeyStartedAt,
    required this.journeyStatus,
    required this.userMood,
  });
  @override
  List<Object?> get props {
    return [
      id,
      subjectInformation,
      targetFocus,
      lifePriorities,
      lifeSatisfactionRatings,
      attemptedQuestions,
      journey,
      journeyStartedAt,
      journeyStatus,
      userMood,
    ];
  }

  @override
  bool get stringify => true;

  HubStatus copyWith({
    int? id,
    SubjectInformationModel? subjectInformation,
    TargetFocusList? targetFocus,
    LifePriorities? lifePriorities,
    Map<String, LifeRatingResult>? lifeSatisfactionRatings,
    bool? attemptedQuestions,
    Journey? journey,
    DateTime? journeyStartedAt,
    String? journeyStatus,
    String? userMood,
  }) {
    return HubStatus(
      id: id ?? this.id,
      subjectInformation: subjectInformation ?? this.subjectInformation,
      targetFocus: targetFocus ?? this.targetFocus,
      lifePriorities: lifePriorities ?? this.lifePriorities,
      lifeSatisfactionRatings:
          lifeSatisfactionRatings ?? this.lifeSatisfactionRatings,
      attemptedQuestions: attemptedQuestions ?? this.attemptedQuestions,
      journey: journey ?? this.journey,
      journeyStartedAt: journeyStartedAt ?? this.journeyStartedAt,
      journeyStatus: journeyStatus ?? this.journeyStatus,
      userMood: userMood ?? this.userMood,
    );
  }
}
