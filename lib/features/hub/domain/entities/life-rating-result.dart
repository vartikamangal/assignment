import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:tatsam_app_experimental/features/hub/domain/entities/individual-satisfaction-rating-result.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/subject-id.dart';

class LifeRatingResult extends Equatable {
  final int id;
  final SubjectId subjectId;
  final String wolArea;
  final IndividualSatisfactionRating rating;
  final DateTime createdWhen;
  const LifeRatingResult({
    @required this.id,
    @required this.subjectId,
    @required this.wolArea,
    @required this.rating,
    @required this.createdWhen,
  });
  @override
  List<Object> get props {
    return [
      id,
      subjectId,
      wolArea,
      rating,
      createdWhen,
    ];
  }

  LifeRatingResult copyWith({
    int id,
    SubjectId subjectId,
    String wolArea,
    IndividualSatisfactionRating rating,
    DateTime createdWhen,
  }) {
    return LifeRatingResult(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      wolArea: wolArea ?? this.wolArea,
      rating: rating ?? this.rating,
      createdWhen: createdWhen ?? this.createdWhen,
    );
  }

  @override
  bool get stringify => true;
}
