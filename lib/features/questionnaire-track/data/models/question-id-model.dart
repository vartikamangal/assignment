// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import '../../domain/entities/question-id.dart';

class QuestionIdModel extends QuestionId {
  const QuestionIdModel({
    @required String id,
  }) : super(
          id: id,
        );

  factory QuestionIdModel.fromJson(Map<String, dynamic> jsonMap) {
    return QuestionIdModel(
      id: jsonMap['id'] as String,
    );
  }

  Map<String, String> toJson() {
    return {
      "id": id,
    };
  }
}
