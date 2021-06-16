// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import '../../../../core/image/image.dart';
import '../../domain/entities/default-rating-scale.dart';

class DefaultRatingScaleModel extends DefaultRatingScale {
  const DefaultRatingScaleModel({
    @required int id,
    @required String ratingScaleName,
    @required int minValue,
    @required int maxValue,
    @required ImageProp icon,
  }) : super(
          icon: icon,
          ratingScaleName: ratingScaleName,
          id: id,
          minValue: minValue,
          maxValue: maxValue,
        );

  factory DefaultRatingScaleModel.fromJson(Map<String, dynamic> jsonMap) {
    return DefaultRatingScaleModel(
      id: jsonMap['id'] as int,
      ratingScaleName: jsonMap['ratingScaleName'] as String,
      minValue: jsonMap['minValue'] as int,
      maxValue: jsonMap['maxValue'] as int,
      //TODO to be replaced with actual ImagePropModel once implemented
      icon: const ImageProp(
        urlLarge: '',
        urlMedium: '',
        urlShort: '',
      ),
    );
  }
}
