// Flutter imports:

// Project imports:
import '../../../../core/image/image.dart';
import '../../domain/entities/default-rating-scale.dart';

class DefaultRatingScaleModel extends DefaultRatingScale {
  DefaultRatingScaleModel({
    required int? id,
    required String? ratingScaleName,
    required int? minValue,
    required int? maxValue,
    required ImageModel? icon,
  }) : super(
          icon: icon?.toDomain(),
          ratingScaleName: ratingScaleName,
          id: id,
          minValue: minValue,
          maxValue: maxValue,
        );

  factory DefaultRatingScaleModel.fromJson(Map<String, dynamic> jsonMap) {
    return DefaultRatingScaleModel(
      id: jsonMap['id'] as int?,
      ratingScaleName: jsonMap['ratingScaleName'] as String?,
      minValue: jsonMap['minValue'] as int?,
      maxValue: jsonMap['maxValue'] as int?,
      icon: jsonMap['icon'] == null
          ? ImageModel.fallbackIcon()
          : ImageModel.fromJson(jsonMap['iconVO'] as Map<String, dynamic>),
    );
  }
}
