import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-model.dart';

import '../../domain/entities/cached-mood.dart';

class CachedMoodModel extends CachedMood {
  const CachedMoodModel({
    required int? moodId,
    required String? moodName,
    required String? moodDescription,
    required ImageEntity? moodIcon,
  }) : super(
          moodDescription: moodDescription,
          moodIcon: moodIcon,
          moodId: moodId,
          moodName: moodName,
        );

  factory CachedMoodModel.fromJson(Map<String, dynamic> jsonMap) {
    return CachedMoodModel(
      moodId: jsonMap['moodId'] as int?,
      moodName: jsonMap['moodName'] as String?,
      moodDescription: jsonMap['moodDescription'] as String?,
      //TODO to be added the imagemodel impl later
      moodIcon: null,
    );
  }

  factory CachedMoodModel.fromMood(MoodModel mood) {
    return CachedMoodModel(
      moodId: mood.moodId,
      moodName: mood.moodName,
      moodDescription: mood.moodDescription,
      moodIcon: mood.moodIcon,
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
