// Flutter imports:

import '../../../../core/image/image.dart';
import '../../domain/entities/instant-relief-area.dart';

class InstantReliefAreaModel extends InstantReliefArea {
  InstantReliefAreaModel({
    required int? id,
    required String? title,
    required String? subtitle,
    required String? instantReliefName,
    required String? description,
    required ImageModel? icon,
  }) : super(
          description: description,
          icon: icon?.toDomain(),
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
      icon: jsonMap['iconVO'] == null
          ? ImageModel.fallbackIcon()
          : ImageModel.fromJson(jsonMap['iconVO'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "subtitle": subtitle,
      "instantReliefName": instantReliefName,
      "description": description,
      "iconVO": ImageModel.fromDomain(icon!).toJson(),
    };
  }
}
