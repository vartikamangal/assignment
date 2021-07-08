import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/activity/domain/entities/tag.dart';
import 'question-info.dart';
import '../../../questionnaire-track/domain/entities/question-option.dart';

class ProfileQuestion extends Equatable {
  final String? id;
  final String? questionType;
  final String? status;
  final DateTime creationTime;
  final DateTime lastModifiedTime;
  final String? name;
  final List<Tag> tags;
  final List<QuestionOption> questionOptions;
  final QuestionInfo questionInformation;
  const ProfileQuestion({
    required this.id,
    required this.questionType,
    required this.status,
    required this.creationTime,
    required this.lastModifiedTime,
    required this.name,
    required this.tags,
    required this.questionOptions,
    required this.questionInformation,
  });
  @override
  List<Object?> get props {
    return [
      id,
      questionType,
      status,
      creationTime,
      lastModifiedTime,
      name,
      tags,
      questionOptions,
      questionInformation,
    ];
  }

  @override
  bool get stringify => true;
}
