// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import '../../../../core/image/image.dart';
import '../../domain/entities/mood.dart';

class MoodModel extends Mood {
  const MoodModel({
    @required int id,
    @required String moodName,
    @required String moodDescription,
    @required ImageProp icon,
  }) : super(
          moodName: moodName,
          moodId: id,
          moodDescription: moodDescription,
          moodIcon: icon,
        );

  factory MoodModel.fromJson(Map<String, dynamic> jsonMap) {
    return MoodModel(
      id: jsonMap['id'] as int,
      moodName: jsonMap['moodName'] as String,
      moodDescription: jsonMap['moodDescription'] as String,
      //todo To be change with real image logic later
      icon: const ImageProp(
        urlLarge: '',
        urlMedium: '',
        urlShort: '',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": moodId,
      "moodName": moodName,
      "moodDescription": moodDescription,
      //todo To be change with real image logic later
      "icon": null
    };
  }
}
