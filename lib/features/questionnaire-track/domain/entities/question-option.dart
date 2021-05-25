import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/entities/rating-scale.dart';

class QuestionOption extends Equatable {
  final String id;
  final String optionText;
  final String optionCategory;
  final List<RatingScale> additionalInformation;
  const QuestionOption({
    @required this.id,
    @required this.optionText,
    @required this.optionCategory,
    @required this.additionalInformation,
  });
  @override
  List<Object> get props =>
      [id, optionText, optionCategory, additionalInformation];

  @override
  bool get stringify => true;
}
