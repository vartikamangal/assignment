import 'package:flutter/foundation.dart';
import '../../domain/entities/cached-mood.dart';
import '../../../image/image.dart';

class CachedMoodModel extends CachedMood {
  const CachedMoodModel({
    @required int moodId,
    @required String moodName,
    @required String moodDescription,
    @required ImageProp moodIcon,
  }) : super(
          moodDescription: moodDescription,
          moodIcon: moodIcon,
          moodId: moodId,
          moodName: moodName,
        );

  factory CachedMoodModel.fromJson(Map<String, dynamic> jsonMap) {
    return CachedMoodModel(
      moodId: jsonMap['moodId'] as int,
      moodName: jsonMap['moodName'] as String,
      moodDescription: jsonMap['moodDescription'] as String,
      //TODO to be added the imagemodel impl later
      moodIcon: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'moodId': moodId,
      'moodName': moodName,
      'moodDescription': moodDescription,
      //TODO to be added the imagemodel impl later
      'moodIcon': null,
    };
  }
}
