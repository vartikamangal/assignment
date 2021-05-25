import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tatsam_app_experimental/features/questionnaire-track/domain/entities/question.dart';

class Questionnaire extends Equatable {
  final String id;
  final String name;
  final String title;
  final String description;
  final String creationDate;
  final List<Question> questionVO;

  const Questionnaire({
    @required this.id,
    @required this.name,
    @required this.title,
    @required this.description,
    @required this.creationDate,
    @required this.questionVO,
  });
  @override
  List<Object> get props {
    return [
      id,
      name,
      title,
      description,
      creationDate,
      questionVO,
    ];
  }

  @override
  bool get stringify => true;

  Questionnaire copyWith({
    String id,
    String name,
    String title,
    String description,
    String creationDate,
    List<Question> questionVO,
  }) {
    return Questionnaire(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      description: description ?? this.description,
      creationDate: creationDate ?? this.creationDate,
      questionVO: questionVO ?? this.questionVO,
    );
  }
}
