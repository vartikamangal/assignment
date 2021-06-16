import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class QuestionInfo extends Equatable {
  final int id;
  final String questionText;
  final String questionExplanation;
  const QuestionInfo({
    @required this.id,
    @required this.questionText,
    @required this.questionExplanation,
  });
  @override
  List<Object> get props => [id, questionText, questionExplanation];
}
