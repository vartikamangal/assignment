// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'question-id.dart';
import 'question-option.dart';

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
