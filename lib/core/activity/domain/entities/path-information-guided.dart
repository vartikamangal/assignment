// Flutter imports:
// Package imports:
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/entity.dart';

class PathInformation extends Entity {
  final int id;
  final String description;
  final String title;
  final String subtitle;
  final String helpContent;
  final int lengthOfPlan;

  PathInformation({
    required this.id,
    required this.description,
    required this.title,
    required this.subtitle,
    required this.helpContent,
    required this.lengthOfPlan,
  });

  PathInformation copyWith({
    int? id,
    String? description,
    String? title,
    String? subtitle,
    String? helpContent,
    int? lengthOfPlan,
  }) {
    return PathInformation(
      id: id ?? this.id,
      description: description ?? this.description,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      helpContent: helpContent ?? this.helpContent,
      lengthOfPlan: lengthOfPlan ?? this.lengthOfPlan,
    );
  }

  @override
  String toString() {
    return 'PathInformation(id: $id, description: $description, title: $title, subtitle: $subtitle, helpContent: $helpContent, lengthOfPlan: $lengthOfPlan)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PathInformation &&
        other.id == id &&
        other.description == description &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.helpContent == helpContent &&
        other.lengthOfPlan == lengthOfPlan;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        title.hashCode ^
        subtitle.hashCode ^
        helpContent.hashCode ^
        lengthOfPlan.hashCode;
  }
}
