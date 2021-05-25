import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:tatsam_app_experimental/features/hub/domain/entities/life-rating-result.dart';

class LifeSatisfactionRatings extends Equatable {
  final int id;
  final Map<String, LifeRatingResult> lifeSatisfactionRatings;
  const LifeSatisfactionRatings({
    @required this.id,
    @required this.lifeSatisfactionRatings,
  });
  @override
  List<Object> get props => [id, lifeSatisfactionRatings];

  LifeSatisfactionRatings copyWith({
    int id,
    Map<String, LifeRatingResult> lifeSatisfactionRatings,
  }) {
    return LifeSatisfactionRatings(
      id: id ?? this.id,
      lifeSatisfactionRatings:
          lifeSatisfactionRatings ?? this.lifeSatisfactionRatings,
    );
  }

  @override
  bool get stringify => true;
}
