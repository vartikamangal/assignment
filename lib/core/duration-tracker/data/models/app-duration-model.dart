import 'package:flutter/foundation.dart';
import 'package:tatsam_app_experimental/core/duration-tracker/domain/entities/app-duration.dart';

class AppDurationModel extends AppDuration {
  const AppDurationModel({
    @required DateTime lastLogin,
    @required int currentWeekday,
  }) : super(
          currentWeekday: currentWeekday,
          lastLogin: lastLogin,
        );

  factory AppDurationModel.frmoJson(Map<String, dynamic> jsonMap) {
    return AppDurationModel(
      lastLogin: DateTime.parse(jsonMap['lastLogin'] as String),
      currentWeekday: jsonMap['currentWeekday'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "currentWeekday": currentWeekday,
      "lastLogin": lastLogin.toString(),
    };
  }

  AppDurationModel copyWith({
    DateTime lastLogin,
    int currentWeekday,
  }) {
    return AppDurationModel(
      lastLogin: lastLogin ?? this.lastLogin,
      currentWeekday: currentWeekday ?? this.currentWeekday,
    );
  }
}
