// Flutter imports:
// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../core/image/image.dart';

class RecommendationCategory extends Equatable {
  final int? id;
  final String? categoryName;
  final String? displayTitle;
  final String? displaySubtitle;
  final String? categoryDetailedDescription;
  final String? categoryShortDescription;
  final String? iconVO;
  const RecommendationCategory({
    required this.id,
    required this.categoryName,
    required this.displayTitle,
    required this.displaySubtitle,
    required this.categoryDetailedDescription,
    required this.categoryShortDescription,
    required this.iconVO,
  });
  @override
  List<Object?> get props {
    return [
      id,
      categoryName,
      displayTitle,
      displaySubtitle,
      categoryDetailedDescription,
      categoryShortDescription,
      iconVO,
    ];
  }

  RecommendationCategory copyWith({
    int? id,
    String? categoryName,
    String? displayTitle,
    String? displaySubtitle,
    String? categoryDetailedDescription,
    String? categoryShortDescription,
    String? iconVO,
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
  bool get stringify => true;
}
