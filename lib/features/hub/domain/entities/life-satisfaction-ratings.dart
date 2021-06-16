// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'life-rating-result.dart';

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
