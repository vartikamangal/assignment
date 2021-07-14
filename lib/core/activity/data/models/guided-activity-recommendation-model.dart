// Flutter imports:
import 'package:tatsam_app_experimental/core/activity/data/models/activity-model.dart';
import 'package:tatsam_app_experimental/features/view-all-content/data/models/data-model.dart';

// Project imports:
import '../../../../core/image/image.dart';
import '../../domain/entities/guided-activity-recommendation.dart';

class GuidedActivityRecommendationModel
    extends DataModel<GuidedActivityRecommendation> {
  int? id;
  int? dayNumber;
  ImageModel? icon;
  String? description;
  String? title;
  String? subtitle;
  String? helpContent;
  List<ActivityModel>? recommendationList;

  GuidedActivityRecommendationModel.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] as int?,
        dayNumber = jsonMap['dayNumber'] as int,
        icon = jsonMap["icon"] != null
            ? ImageModel.fromJson(jsonMap['icon'] as Map<String, dynamic>)
            : ImageModel.fallbackIcon(),
        description = jsonMap['description'] as String,
        title = jsonMap['title'] as String,
        subtitle = jsonMap['subtitle'] as String,
        helpContent = jsonMap['helpContent'] as String,
        recommendationList = (jsonMap['recommendationList'] as List)
            .map(
              (recommendation) => ActivityModel.fromJson(
                recommendation as Map<String, dynamic>,
              ),
            )
            .toList();

  GuidedActivityRecommendationModel.fromDomain(
      GuidedActivityRecommendation recommendation)
      : id = recommendation.id,
        icon = ImageModel.fromDomain(recommendation.icon!),
        dayNumber = recommendation.dayNumber,
        description = recommendation.description,
        title = recommendation.title,
        subtitle = recommendation.subtitle,
        helpContent = recommendation.helpContent,
        recommendationList = recommendation.recommendationList
            .map((activity) => ActivityModel.fromDomain(activity))
            .toList();

  @override
  GuidedActivityRecommendation toDomain() {
    return GuidedActivityRecommendation(
      id: id,
      dayNumber: dayNumber,
      icon: icon?.toDomain(),
      description: description,
      title: title,
      subtitle: subtitle,
      helpContent: helpContent,
      recommendationList:
          recommendationList!.map((activity) => activity.toDomain()).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
