// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import '../../../rapport-building/data/models/subject-id-model.dart';
import '../../domain/entities/life-rating-result.dart';
import 'individual-satisfaction-rating-result-model.dart';

class LifeRatingResultModel extends LifeRatingResult {
  const LifeRatingResultModel({
    @required int id,
    @required SubjectIdModel subjectId,
    @required String wolArea,
    @required IndividualSatisfactionRatingResultModel rating,
    @required DateTime createdWhen,
  }) : super(
          createdWhen: createdWhen,
          rating: rating,
          id: id,
          subjectId: subjectId,
          wolArea: wolArea,
        );

  factory LifeRatingResultModel.fromJson(Map<String, dynamic> jsonMap) {
    return LifeRatingResultModel(
      id: jsonMap[''] as int,
      subjectId: SubjectIdModel.fromJson(
        jsonMap: jsonMap['subjectId'] as Map<String, dynamic>,
      ),
      wolArea: jsonMap['wolArea'] as String,
      rating: IndividualSatisfactionRatingResultModel.fromJson(
        jsonMap['rating'] as Map<String, dynamic>,
      ),
      createdWhen: DateTime.parse(
        jsonMap['createdWhen'] as String,
      ),
    );
  }
}
