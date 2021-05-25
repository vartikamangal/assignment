import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'satisfaction-rating-map-for-time-provision-scale.dart';

class SatisfactionRatings extends Equatable {
  final List<SatisfactionRatingMapForTimeProvision> satisfactionRatings;

  const SatisfactionRatings({@required this.satisfactionRatings});
  @override
  List<Object> get props => [satisfactionRatings];
}
