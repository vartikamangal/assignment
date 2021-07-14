// Flutter imports:
// Package imports:
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/entity.dart';

// Project imports:
import '../../../../core/image/image.dart';

class RecommendationCategory extends Entity {
  final int? id;
  final String? categoryName;
  final String? displayTitle;
  final String? displaySubtitle;
  final String? categoryDetailedDescription;
  final String? categoryShortDescription;
  final ImageEntity? iconVO;
  RecommendationCategory({
    required this.id,
    required this.categoryName,
    required this.displayTitle,
    required this.displaySubtitle,
    required this.categoryDetailedDescription,
    required this.categoryShortDescription,
    required this.iconVO,
  });

  RecommendationCategory copyWith({
    int? id,
    String? categoryName,
    String? displayTitle,
    String? displaySubtitle,
    String? categoryDetailedDescription,
    String? categoryShortDescription,
    ImageEntity? iconVO,
  }) {
    return RecommendationCategory(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
      displayTitle: displayTitle ?? this.displayTitle,
      displaySubtitle: displaySubtitle ?? this.displaySubtitle,
      categoryDetailedDescription:
          categoryDetailedDescription ?? this.categoryDetailedDescription,
      categoryShortDescription:
          categoryShortDescription ?? this.categoryShortDescription,
      iconVO: iconVO ?? this.iconVO,
    );
  }

  @override
  String toString() {
    return 'RecommendationCategory(id: $id, categoryName: $categoryName, displayTitle: $displayTitle, displaySubtitle: $displaySubtitle, categoryDetailedDescription: $categoryDetailedDescription, categoryShortDescription: $categoryShortDescription, iconVO: $iconVO)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecommendationCategory &&
        other.id == id &&
        other.categoryName == categoryName &&
        other.displayTitle == displayTitle &&
        other.displaySubtitle == displaySubtitle &&
        other.categoryDetailedDescription == categoryDetailedDescription &&
        other.categoryShortDescription == categoryShortDescription &&
        other.iconVO == iconVO;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        categoryName.hashCode ^
        displayTitle.hashCode ^
        displaySubtitle.hashCode ^
        categoryDetailedDescription.hashCode ^
        categoryShortDescription.hashCode ^
        iconVO.hashCode;
  }
}
