// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/tag.dart';
import 'question-option.dart';

class Question extends Equatable {
  final String? id;
  final String? questionType;
  final String? status;
  final String? name;
  final List<Tag> tags;
  final List<QuestionOption> questionOptionVO;
  final String? questionText;
  final String? questionExplanation;
  final String? creationTime;
  final String? lastModifiedTime;
  final String? questionnaireId;

  const Question({
    required this.id,
    required this.questionType,
    required this.status,
    required this.name,
    required this.tags,
    required this.questionOptionVO,
    required this.questionText,
    required this.questionExplanation,
    required this.creationTime,
    required this.lastModifiedTime,
    required this.questionnaireId,
  });
  @override
  List<Object?> get props {
    return [
      id,
      questionType,
      status,
      name,
      tags,
      questionOptionVO,
      questionText,
      questionExplanation,
      creationTime,
      lastModifiedTime,
      questionnaireId,
    ];
  }

  @override
  bool get stringify => true;
}
