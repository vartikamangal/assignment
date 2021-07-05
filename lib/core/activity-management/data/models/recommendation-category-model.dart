// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import '../../../../core/image/image.dart';
import '../../domain/entities/recommendation-category.dart';

class RecommendationCategoryModel extends RecommendationCategory {
  const RecommendationCategoryModel({
    required int? id,
    required String? categoryName,
    required String? displayTitle,
    required String? displaySubtitle,
    required String? categoryDetailedDescription,
    required String? categoryShortDescription,
    required ImageProp? iconVO,
  }) : super(
          id: id,
          categoryDetailedDescription: categoryDetailedDescription,
          categoryName: categoryName,
          categoryShortDescription: categoryShortDescription,
          iconVO: iconVO,
          displaySubtitle: displaySubtitle,
          displayTitle: displayTitle,
        );

  factory RecommendationCategoryModel.fromJson(Map<String, dynamic> jsonMap) {
    return RecommendationCategoryModel(
      id: jsonMap['id'] as int?,
      categoryName: jsonMap['categoryName'] as String?,
      displayTitle: jsonMap['displayTitle'] as String?,
      displaySubtitle: jsonMap['displaySubtitle'] as String?,
      categoryDetailedDescription:
          jsonMap['categoryDetailedDescription'] as String?,
      categoryShortDescription: jsonMap['categoryShortDescription'] as String?,
      //TODO Fix this once images are there on server
      iconVO: const ImageProp(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": 2,
      "categoryName": categoryName,
      "displayTitle": displayTitle,
      "displaySubtitle": displaySubtitle,
      "categoryDetailedDescription": categoryDetailedDescription,
      "categoryShortDescription": categoryShortDescription,
      "iconVO": null,
    };
  }
}
