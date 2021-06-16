// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import '../../domain/entities/questionnaire.dart';
import 'question-model.dart';

class QuestionnaireModel extends Questionnaire {
  const QuestionnaireModel({
    @required String id,
    @required String name,
    @required String title,
    @required String description,
    @required String creationDate,
    @required List<QuestionModel> questionVO,
  }) : super(
          id: id,
          name: name,
          title: title,
          description: description,
          questionVO: questionVO,
          creationDate: creationDate,
        );

  factory QuestionnaireModel.fromJson(Map<String, dynamic> jsonMap) {
    return QuestionnaireModel(
      id: jsonMap['id'] as String,
      name: jsonMap['name'] as String,
      title: jsonMap['title'] as String,
      description: jsonMap['description'] as String,
      creationDate: jsonMap['creationDate'] as String ?? 'N/A',
      questionVO: (jsonMap['questionVO'] as List)
          .map(
            (question) => QuestionModel.fromJson(
              question as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "title": title,
      "description": description,
      "creationDate": creationDate,
      "questionVO": questionVO,
    };
  }
}
