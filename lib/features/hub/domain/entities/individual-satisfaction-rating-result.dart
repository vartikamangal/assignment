// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'default-rating-scale.dart';

class IndividualSatisfactionRating extends Equatable {
  final int id;
  final int rating;
  final DefaultRatingScale scale;
  const IndividualSatisfactionRating({
    @required this.id,
    @required this.rating,
    @required this.scale,
  });
  @override
  List<Object> get props => [id, rating, scale];

  @override
  bool get stringify => true;

  IndividualSatisfactionRating copyWith({
    int id,
    int rating,
    DefaultRatingScale scale,
  }) {
    return IndividualSatisfactionRating(
      id: id ?? this.id,
      rating: rating ?? this.rating,
      scale: scale ?? this.scale,
    );
  }
}
