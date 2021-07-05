// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import '../../domain/entities/feeling.dart';

class FeelingModel extends Feeling {
  const FeelingModel({required String? feeling}) : super(feeling: feeling);

  factory FeelingModel.fromJson(Map<String, dynamic> jsonMap) {
    return FeelingModel(
      feeling: jsonMap['feeling'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "feeling": feeling,
    };
  }
}
