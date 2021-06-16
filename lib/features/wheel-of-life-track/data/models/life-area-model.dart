// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import '../../domain/entities/life-area.dart';

class LifeAreaModel extends LifeArea {
  const LifeAreaModel({
    @required String areaCode,
    @required String name,
    @required String description,
  }) : super(
          name: name,
          description: description,
          areaCode: areaCode,
        );

  factory LifeAreaModel.fromJson(Map<String, dynamic> jsonMap) {
    return LifeAreaModel(
      areaCode: jsonMap['areaName'] as String,
      name: jsonMap['displayName'] as String,
      description: jsonMap['areaDescription'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "areaName": areaCode,
      "displayName": name,
      "areaDescription": description,
    };
  }
}
