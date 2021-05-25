import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question-id.dart';

import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question-option.dart';

class Answer extends Equatable {
  final QuestionId question;
  final List<QuestionOption> optionChosen;
  final String additionalInformation;
  const Answer({
    @required this.question,
    @required this.optionChosen,
    @required this.additionalInformation,
  });
  @override
  List<Object> get props => [question, optionChosen, additionalInformation];

  Answer copyWith({
    QuestionId question,
    List<QuestionOption> optionChosen,
    String additionalInformation,
  }) {
    return Answer(
      question: question ?? this.question,
      optionChosen: optionChosen ?? this.optionChosen,
      additionalInformation:
          additionalInformation ?? this.additionalInformation,
    );
  }

  @override
  bool get stringify => true;
}
