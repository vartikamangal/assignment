// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'satisfaction-rating-map-for-time-provision-scale.dart';

class SatisfactionRatings extends Equatable {
  final List<SatisfactionRatingMapForTimeProvision> satisfactionRatings;

  const SatisfactionRatings({@required this.satisfactionRatings});
  @override
  List<Object> get props => [satisfactionRatings];
}
