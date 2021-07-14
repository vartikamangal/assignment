// Flutter imports:

// Project imports:
import '../../../../core/image/image.dart';
import '../../domain/entites/journey.dart';

class JourneyModel extends Journey {
  JourneyModel({
    required int? id,
    required String? title,
    required String? subtitle,
    required String? description,
    required ImageModel? icon,
    required String? pathName,
  }) : super(
          pathName: pathName,
          subtitle: subtitle,
          title: title,
          icon: icon?.toDomain(),
          description: description,
          id: id,
        );

  factory JourneyModel.fromJson(Map<String, dynamic> jsonMap) {
    return JourneyModel(
      id: jsonMap['id'] as int?,
      title: jsonMap['title'] as String?,
      subtitle: jsonMap['subtitle'] as String?,
      description: jsonMap['description'] as String?,
      icon: jsonMap['iconVO'] == null
          ? ImageModel.fallbackIcon()
          : ImageModel.fromJson(jsonMap['iconVO'] as Map<String, dynamic>),
      pathName: jsonMap['pathName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    print(icon);
    return {
      "id": id,
      "title": title,
      "subtitle": subtitle,
      "iconVO": ImageModel.fromDomain(icon!).toJson(),
      "description": description,
      "pathName": pathName,
    };
  }
}
