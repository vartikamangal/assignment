import 'package:flutter/cupertino.dart';
import '../../domain/entities/subject-id.dart';

class SubjectIdModel extends SubjectId {
  const SubjectIdModel({@required String id}) : super(id);

  factory SubjectIdModel.fromJson({@required Map<String, dynamic> jsonMap}) {
    return SubjectIdModel(id: jsonMap['id'] as String);
  }

  Map<String, dynamic> toJson() {
    return {"id": id};
  }
}
