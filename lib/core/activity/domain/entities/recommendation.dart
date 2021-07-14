// Flutter imports:
// Package imports:
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/entity.dart';

// Project imports:
import 'activity.dart';

class Recommendation extends Entity {
  final Activity activity;
  final double weight;
  Recommendation({
    required this.activity,
    required this.weight,
  });

  Recommendation copyWith({
    Activity? activity,
    double? weight,
  }) {
    return Recommendation(
      activity: activity ?? this.activity,
      weight: weight ?? this.weight,
    );
  }

  @override
  String toString() => 'Recommendation(activity: $activity, weight: $weight)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Recommendation &&
        other.activity == activity &&
        other.weight == weight;
  }

  @override
  int get hashCode => activity.hashCode ^ weight.hashCode;
}
