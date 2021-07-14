// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../core/image/image.dart';

class DefaultRatingScale extends Equatable {
  final int? id;
  final String? ratingScaleName;
  final int? minValue;
  final int? maxValue;
  final ImageEntity? icon;
  const DefaultRatingScale({
    required this.id,
    required this.ratingScaleName,
    required this.minValue,
    required this.maxValue,
    required this.icon,
  });
  @override
  List<Object?> get props {
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
    int? id,
    String? ratingScaleName,
    int? minValue,
    int? maxValue,
    ImageEntity? icon,
  }) {
    return DefaultRatingScale(
      id: id ?? this.id,
      ratingScaleName: ratingScaleName ?? this.ratingScaleName,
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
      icon: icon ?? this.icon
    );
  }
}
