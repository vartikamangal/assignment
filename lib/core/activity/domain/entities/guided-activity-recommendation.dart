// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../core/image/image.dart';
import 'recommendation-activity.dart';

//? Will also be used as returning response in daywise plan api guided
class GuidedActivityRecommendation extends Equatable {
  final int? id;
  final int? dayNumber;
  final ImageProp? icon;
  final String? description;
  final String? title;
  final String? subtitle;
  final String? helpContent;
  // Difference SELF & GUIDED varNames are will be leading to either code-duplicacy or second-condition cehck
  // Currently going with the extra condition check method {in models}
  final List<ActivityRecommendation> recommendationList;
  const GuidedActivityRecommendation({
    required this.id,
    required this.dayNumber,
    required this.icon,
    required this.description,
    required this.title,
    required this.subtitle,
    required this.helpContent,
    required this.recommendationList,
  });
  @override
  List<Object?> get props {
    return [
      id,
      dayNumber,
      icon,
      description,
      title,
      subtitle,
      helpContent,
      recommendationList,
    ];
  }

  @override
  bool get stringify => true;
}
