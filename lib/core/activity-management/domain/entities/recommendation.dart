// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'recommendation-activity.dart';

class Recommendation extends Equatable {
  final ActivityRecommendation activity;
  final double weight;
  const Recommendation({
    required this.activity,
    required this.weight,
  });
  @override
  // TODO: implement props
  List<Object> get props => [activity, weight];

  Recommendation copyWith({
    ActivityRecommendation? activity,
    double? weight,
  }) {
    return Recommendation(
      activity: activity ?? this.activity,
      weight: weight ?? this.weight,
    );
  }
  @override
  bool get stringify => true;
}
