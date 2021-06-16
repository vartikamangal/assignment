// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/cache-manager/domain/entities/cache-acitivty.dart';

class CacheAcitivityModel extends CacheAcitivty {
  const CacheAcitivityModel({
    @required String id,
    @required String title,
    @required String subtitle,
    @required String icon,
  }) : super(
          subtitle: subtitle,
          icon: icon,
          id: id,
          title: title,
        );

  factory CacheAcitivityModel.fromJson(Map<String, dynamic> jsonMap) {
    return CacheAcitivityModel(
      id: jsonMap['id'] as String,
      title: jsonMap['title'] as String,
      subtitle: jsonMap['subtitle'] as String,
      icon: jsonMap['icon'] as String,
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
