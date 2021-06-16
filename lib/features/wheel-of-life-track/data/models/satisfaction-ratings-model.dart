// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import '../../domain/entities/satisfaction-rating-map-for-time-provision-scale.dart';
import '../../domain/entities/satisfaction-ratings.dart';

class SatisfactionRatingsModel extends SatisfactionRatings {
  const SatisfactionRatingsModel({
    @required
        final List<SatisfactionRatingMapForTimeProvision> satisfactionRatings,
  }) : super(satisfactionRatings: satisfactionRatings);

  Map<String, Map> toJson() {
    final Map<String, Map<String, dynamic>> jsonMap = {};
    // ignore: avoid_function_literals_in_foreach_calls
    satisfactionRatings.forEach((satisfactionRating) {
      jsonMap.addAll({
        satisfactionRating.lifeArea.areaCode:
            satisfactionRating.rating.toJson(),
      });
    });
    return jsonMap;
  }
}
