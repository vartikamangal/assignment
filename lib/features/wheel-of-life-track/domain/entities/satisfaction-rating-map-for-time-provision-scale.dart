import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../data/models/life-area-model.dart';
import '../../data/models/rating-scale-model.dart';

class SatisfactionRatingMapForTimeProvision extends Equatable {
  final LifeAreaModel lifeArea;
  RatingScaleModel rating;

  SatisfactionRatingMapForTimeProvision({
    @required this.lifeArea,
    @required this.rating,
  });

  @override
  List<Object> get props => [lifeArea, rating];
}
