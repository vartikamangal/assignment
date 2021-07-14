// Flutter imports:

// Project imports:
import '../../domain/entities/feeling-duration.dart';

class FeelingDurationModel extends FeelingDuration {
  const FeelingDurationModel({
    required String? durationName,
    required String? durationSequence,
    required String? durationDisplayName,
  }) : super(
          durationDisplayName: durationDisplayName,
          durationName: durationName,
          durationSequence: durationSequence,
        );

  factory FeelingDurationModel.fromJson(Map<String, dynamic> jsonMap) {
    return FeelingDurationModel(
      durationName: jsonMap['DURATION_ENUM_NAME'] as String?,
      durationSequence: jsonMap['DURATION_SEQUENCE'] as String?,
      durationDisplayName: jsonMap['DURATION_DISPLAY_NAME'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "DURATION_ENUM_NAME": durationName,
      "DURATION_SEQUENCE": durationSequence,
      "DURATION_DISPLAY_NAME": durationDisplayName,
    };
  }
}
