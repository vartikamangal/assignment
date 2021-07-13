// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import '../../../../core/image/image.dart';
import '../../domain/entities/instant-relief-area.dart';

class InstantReliefAreaModel extends InstantReliefArea {
  const InstantReliefAreaModel({
    required int? id,
    required String? title,
    required String? subtitle,
    required String? instantReliefName,
    required String? description,
    required String? icon,
  }) : super(
          description: description,
          icon: icon,
          id: id,
          title: title,
          instantReliefName: instantReliefName,
          subtitle: subtitle,
        );

  factory InstantReliefAreaModel.fromJson(Map<String, dynamic> jsonMap) {
    return InstantReliefAreaModel(
      id: jsonMap['id'] as int?,
      title: jsonMap['title'] as String?,
      subtitle: jsonMap['subtitle'] as String?,
      instantReliefName: jsonMap['instantReliefName'] as String?,
      description: jsonMap['description'] as String?,
      //TODO make sure to change this once ImageProp.fromJson() is implemented
      icon:jsonMap['iconVO'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "subtitle": subtitle,
      "instantReliefName": instantReliefName,
      "description": description,
      //TODO make sure to change this once ImageProp.toJson() is implemented
      "iconVO": icon,
    };
  }
}
