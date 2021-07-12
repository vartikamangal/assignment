// Flutter imports:
// Project imports:
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/entities/cache-acitivty.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/entities/activity-status.dart';

class CacheAcitivityModel extends CacheAcitivty {
  const CacheAcitivityModel({
    required String? id,
    required String? title,
    required String? subtitle,
    required String? icon,
  }) : super(
          subtitle: subtitle,
          icon: icon,
          id: id,
          title: title,
        );

  factory CacheAcitivityModel.fromJson(Map<String, dynamic> jsonMap) {
    return CacheAcitivityModel(
      id: jsonMap['id'] as String?,
      title: jsonMap['title'] as String?,
      subtitle: jsonMap['subtitle'] as String?,
      icon: jsonMap['icon'] as String?,
    );
  }

  factory CacheAcitivityModel.generateCachableModel(
      {required ActivityStatus activityStatus, required Activity activity}) {
    return CacheAcitivityModel(
      id: activityStatus.id.toString(),
      title: activity.title,
      subtitle: activity.subtitle,
      //TODO to be added later
      icon: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'icon': icon,
    };
  }
}
