// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:equatable/equatable.dart';

class RatingScale extends Equatable {
  final int min;
  final int max;
  int ratingValue;
  final String ratingScaleName;

  RatingScale({
    @required this.min,
    @required this.max,
    @required this.ratingValue,
    @required this.ratingScaleName,
  });
  @override
  List<Object> get props => [min, max];
}
