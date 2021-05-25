import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:tatsam_app_experimental/core/image/image.dart';

class DefaultRatingScale extends Equatable {
  final int id;
  final String ratingScaleName;
  final int minValue;
  final int maxValue;
  final ImageProp icon;
  const DefaultRatingScale({
    @required this.id,
    @required this.ratingScaleName,
    @required this.minValue,
    @required this.maxValue,
    @required this.icon,
  });
  @override
  List<Object> get props {
    return [
      id,
      ratingScaleName,
      minValue,
      maxValue,
      icon,
    ];
  }

  @override
  bool get stringify => true;

  DefaultRatingScale copyWith({
    int id,
    String ratingScaleName,
    int minValue,
    int maxValue,
    ImageProp icon,
  }) {
    return DefaultRatingScale(
      id: id ?? this.id,
      ratingScaleName: ratingScaleName ?? this.ratingScaleName,
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
      icon: icon ?? this.icon,
    );
  }
}
