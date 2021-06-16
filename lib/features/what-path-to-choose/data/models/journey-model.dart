// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import '../../../../core/image/image.dart';
import '../../domain/entites/journey.dart';

class JourneyModel extends Journey {
  const JourneyModel({
    @required int id,
    @required String title,
    @required String subtitle,
    @required String description,
    @required ImageProp icon,
    @required String pathName,
  }) : super(
          pathName: pathName,
          subtitle: subtitle,
          title: title,
          icon: icon,
          description: description,
          id: id,
        );

  factory JourneyModel.fromJson(Map<String, dynamic> jsonMap) {
    return JourneyModel(
      id: jsonMap['id'] as int,
      title: jsonMap['title'] as String,
      subtitle: jsonMap['subtitle'] as String,
      description: jsonMap['description'] as String,
      //TODO change this after complete impl of ImageProp
      icon: const ImageProp(
        urlLarge: '',
        urlMedium: '',
        urlShort: '',
      ),
      pathName: jsonMap['pathName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "subtitle": subtitle,
      "iconVO": null,
      "description": description,
      "pathName": pathName,
    };
  }
}
