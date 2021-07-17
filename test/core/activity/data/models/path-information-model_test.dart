import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/features/view-all-content/data/models/data-model.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/entity.dart';

class PathInformation extends Entity {
  final int id;
  final String description;
  final String title;
  final String subtitle;
  final String helpContent;
  final int lengthOfPlan;

  PathInformation({
    required this.id,
    required this.description,
    required this.title,
    required this.subtitle,
    required this.helpContent,
    required this.lengthOfPlan,
  });
}

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

void main() {
  final pathInformation = PathInformation(
      id: 1,
      description: 'description',
      title: 'title',
      subtitle: 'subtitle',
      helpContent: 'helpContent',
      lengthOfPlan: 1);
  test('pagination classes working', () async {
    // "e as TestEntity" shows code is susceptible to runtime typcasting errors
    final tPathInformationModel =
        PathInformationModel.fromDomain(pathInformation);
    final p = tPathInformationModel.toDomain();
    final j = tPathInformationModel.toJson();
    final pm = PathInformationModel.fromJson(j);
  });
}
