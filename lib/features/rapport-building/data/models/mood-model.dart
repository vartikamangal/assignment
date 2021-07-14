// Flutter imports:

// Project imports:
import '../../../../core/image/image.dart';
import '../../domain/entities/mood.dart';

class MoodModel extends Mood {
  MoodModel({
    required int? id,
    required String? moodName,
    required String? moodDescription,
    required ImageModel? icon,
  }) : super(
          moodName: moodName,
          moodId: id,
          moodDescription: moodDescription,
          moodIcon: icon?.toDomain(),
        );

  factory MoodModel.fromJson(Map<String, dynamic> jsonMap) {
    return MoodModel(
      id: jsonMap['id'] as int?,
      moodName: jsonMap['moodName'] as String?,
      moodDescription: jsonMap['moodDescription'] as String?,
      icon: jsonMap['icon'] == null
          ? ImageModel.fallbackIcon()
          : ImageModel.fromJson(jsonMap['icon'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": moodId,
      "moodName": moodName,
      "moodDescription": moodDescription,
      "icon": ImageModel.fromDomain(moodIcon!).toJson()
    };
  }
}
