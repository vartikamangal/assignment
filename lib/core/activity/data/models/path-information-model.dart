// Flutter imports:

// Project imports:
import 'package:tatsam_app_experimental/features/view-all-content/data/models/data-model.dart';

import '../../domain/entities/path-information-guided.dart';

class PathInformationModel extends DataModel<PathInformation> {
  int id;
  String description;
  String title;
  String subtitle;
  String helpContent;
  int lengthOfPlan;

  PathInformationModel.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] as int,
        description = jsonMap['description'] as String,
        title = jsonMap['title'] as String,
        subtitle = jsonMap['subtitle'] as String,
        helpContent = jsonMap['helpContent'] as String,
        lengthOfPlan = jsonMap['lengthOfPlan'] as int;

  PathInformationModel.fromDomain(PathInformation pathInformation)
      : id = pathInformation.id,
        description = pathInformation.description,
        title = pathInformation.title,
        subtitle = pathInformation.subtitle,
        helpContent = pathInformation.helpContent,
        lengthOfPlan = pathInformation.lengthOfPlan;

  @override
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

  @override
  PathInformation toDomain() {
    return PathInformation(
      id: id,
      description: description,
      title: title,
      subtitle: subtitle,
      helpContent: helpContent,
      lengthOfPlan: lengthOfPlan,
    );
  }
}
