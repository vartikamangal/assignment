// Flutter imports:

// Project imports:
import 'package:tatsam_app_experimental/features/view-all-content/data/models/data-model.dart';

import '../../../../core/image/image.dart';
import '../../domain/entities/recommendation-category.dart';

class RecommendationCategoryModel extends DataModel<RecommendationCategory> {
  int? id;
  String? categoryName;
  String? displayTitle;
  String? displaySubtitle;
  String? categoryDetailedDescription;
  String? categoryShortDescription;
  ImageModel? iconVO;

  RecommendationCategoryModel(
      {this.id,
      this.categoryName,
      this.displayTitle,
      this.displaySubtitle,
      this.categoryDetailedDescription,
      this.categoryShortDescription,
      this.iconVO});

  RecommendationCategoryModel.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] as int,
        categoryName = jsonMap['categoryName'] as String,
        displayTitle = jsonMap['displayTitle'] as String,
        displaySubtitle = jsonMap['displaySubtitle'] as String,
        categoryDetailedDescription =
            jsonMap['categoryDetailedDescription'] as String,
        categoryShortDescription =
            jsonMap['categoryShortDescription'] as String,
        iconVO = jsonMap["iconVO"] != null
            ? ImageModel.fromJson(jsonMap['iconVO'] as Map<String, dynamic>)
            : ImageModel.fallbackIcon();

  RecommendationCategoryModel.fromDomain(RecommendationCategory category)
      : id = category.id,
        iconVO = ImageModel.fromDomain(category.iconVO!),
        categoryDetailedDescription = category.categoryDetailedDescription,
        displaySubtitle = category.displaySubtitle,
        displayTitle = category.displayTitle,
        categoryName = category.categoryName,
        categoryShortDescription = category.categoryShortDescription;

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": 2,
      "categoryName": categoryName,
      "displayTitle": displayTitle,
      "displaySubtitle": displaySubtitle,
      "categoryDetailedDescription": categoryDetailedDescription,
      "categoryShortDescription": categoryShortDescription,
      "iconVO": iconVO?.toJson(),
    };
  }

  @override
  RecommendationCategory toDomain() {
    return RecommendationCategory(
      id: id,
      categoryName: categoryName,
      displayTitle: displayTitle,
      displaySubtitle: displaySubtitle,
      categoryDetailedDescription: categoryDetailedDescription,
      categoryShortDescription: categoryShortDescription,
      iconVO: iconVO?.toDomain(),
    );
  }
}
