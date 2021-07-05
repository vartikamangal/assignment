// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import '../../domain/entities/path-information-guided.dart';

class PathInformationModel extends PathInformation {
  const PathInformationModel({
    required int? id,
    required String? description,
    required String? title,
    required String? subtitle,
    required String? helpContent,
    required int? lengthOfPlan,
  }) : super(
          helpContent: helpContent,
          lengthOfPlan: lengthOfPlan,
          title: title,
          subtitle: subtitle,
          description: description,
          id: id,
        );

  factory PathInformationModel.fromJson(Map<String, dynamic> jsonMap) {
    return PathInformationModel(
      id: jsonMap['id'] as int?,
      description: jsonMap['description'] as String?,
      title: jsonMap['title'] as String?,
      subtitle: jsonMap['subtitle'] as String?,
      helpContent: jsonMap['helpContent'] as String?,
      lengthOfPlan: jsonMap['lengthOfPlan'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'title': title,
      'subtitle': subtitle,
      'helpContent': helpContent,
      'lengthOfPlan': lengthOfPlan,
    };
  }
}
