// Flutter imports:
// Package imports:
import 'package:flutter/foundation.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/entity.dart';

// Project imports:
import '../../../../core/image/image.dart';
import 'activity.dart';

class GuidedActivityRecommendation extends Entity {
  final int? id;
  final int? dayNumber;
  final ImageEntity? icon;
  final String? description;
  final String? title;
  final String? subtitle;
  final String? helpContent;
  final List<Activity> recommendationList;

  GuidedActivityRecommendation({
    required this.id,
    required this.dayNumber,
    required this.icon,
    required this.description,
    required this.title,
    required this.subtitle,
    required this.helpContent,
    required this.recommendationList,
  });

  GuidedActivityRecommendation copyWith({
    int? id,
    int? dayNumber,
    ImageEntity? icon,
    String? description,
    String? title,
    String? subtitle,
    String? helpContent,
    List<Activity>? recommendationList,
  }) {
    return GuidedActivityRecommendation(
      id: id ?? this.id,
      dayNumber: dayNumber ?? this.dayNumber,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      helpContent: helpContent ?? this.helpContent,
      recommendationList: recommendationList ?? this.recommendationList,
    );
  }

  @override
  String toString() {
    return 'GuidedActivityRecommendation(id: $id, dayNumber: $dayNumber, icon: $icon, description: $description, title: $title, subtitle: $subtitle, helpContent: $helpContent, recommendationList: $recommendationList)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GuidedActivityRecommendation &&
        other.id == id &&
        other.dayNumber == dayNumber &&
        other.icon == icon &&
        other.description == description &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.helpContent == helpContent &&
        listEquals(other.recommendationList, recommendationList);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dayNumber.hashCode ^
        icon.hashCode ^
        description.hashCode ^
        title.hashCode ^
        subtitle.hashCode ^
        helpContent.hashCode ^
        recommendationList.hashCode;
  }
}
