// Flutter imports:

// Project imports:
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation.dart';
import 'activity-model.dart';

class RecommendationModel extends Recommendation {
  const RecommendationModel({
    required ActivityModel activity,
    required double weight,
  }) : super(
          activity: activity,
          weight: weight,
        );

  factory RecommendationModel.fromJson(Map<String, dynamic> jsonMap) {
    return RecommendationModel(
      activity: ActivityModel.fromJson(
        jsonMap['recommendation'] as Map<String, dynamic>,
      ),
      weight: (jsonMap['weight'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "activity": (activity as ActivityModel).toJson(),
      "weight": weight,
    };
  }
}
