import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'profile-question.dart';
import '../../../questionnaire-track/domain/entities/question-option.dart';

class QuestionLog extends Equatable {
  final int? id;
  final DateTime answeredWhen;
  //change this
  final ProfileQuestion question;
  final List<QuestionOption> optionChosen;
  final String? additionalInformation;

  const QuestionLog({
    required this.id,
    required this.answeredWhen,
    required this.question,
    required this.optionChosen,
    required this.additionalInformation,
  });

  @override
  List<Object?> get props => [
        id,
        answeredWhen,
        question,
        optionChosen,
        additionalInformation,
      ];
}
