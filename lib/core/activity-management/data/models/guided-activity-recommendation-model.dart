// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import '../../../../core/image/image.dart';
import '../../domain/entities/guided-activity-recommendation.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/recommendation-activity-model.dart';

class GuidedActivityRecommendationModel extends GuidedActivityRecommendation {
  const GuidedActivityRecommendationModel({
    required int? id,
    required int? dayNumber,
    required ImageProp? icon,
    required String? description,
    required String? title,
    required String? subtitle,
    required String? helpContent,
    required List<ActivityRecommendationModel> recommendationList,
  }) : super(
          subtitle: subtitle,
          icon: icon,
          title: title,
          description: description,
          recommendationList: recommendationList,
          id: id,
          dayNumber: dayNumber,
          helpContent: helpContent,
        );

  factory GuidedActivityRecommendationModel.fromJson(
      Map<String, dynamic> jsonMap) {
    return GuidedActivityRecommendationModel(
      id: jsonMap['id'] as int?,
      dayNumber: jsonMap['dayNumber'] as int?,
      //TODO to be implemented once image is done
      icon: const ImageProp(),
      description: jsonMap['description'] as String?,
      title: jsonMap['title'] as String?,
      subtitle: jsonMap['subtitle'] as String?,
      helpContent: jsonMap['helpContent'] as String?,
      recommendationList: (jsonMap['recommendationList'] as List)
          .map(
            (recommendation) => ActivityRecommendationModel.fromJson(
              recommendation as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
}
