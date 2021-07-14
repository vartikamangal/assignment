// Flutter imports:
// Package imports:
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/entity.dart';

class Tag extends Entity {
  final String? name;
  final String? tagCategory;
  final String? displayName;
  final String? parentName;
  Tag({
    required this.name,
    required this.tagCategory,
    required this.displayName,
    required this.parentName,
  });

  @override
  String toString() {
    return 'Tag(name: $name, tagCategory: $tagCategory, displayName: $displayName, parentName: $parentName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tag &&
        other.name == name &&
        other.tagCategory == tagCategory &&
        other.displayName == displayName &&
        other.parentName == parentName;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        tagCategory.hashCode ^
        displayName.hashCode ^
        parentName.hashCode;
  }
}
