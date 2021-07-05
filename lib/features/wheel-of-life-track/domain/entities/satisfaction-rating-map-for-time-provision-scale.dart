// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import '../../data/models/life-area-model.dart';
import '../../data/models/rating-scale-model.dart';

class SatisfactionRatingMapForTimeProvision extends Equatable {
  final LifeAreaModel lifeArea;
  RatingScaleModel rating;

  SatisfactionRatingMapForTimeProvision({
    required this.lifeArea,
    required this.rating,
  });

  @override
  List<Object> get props => [lifeArea, rating];
}
