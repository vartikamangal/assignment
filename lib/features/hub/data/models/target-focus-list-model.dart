import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:tatsam_app_experimental/features/focus/data/models/issue-model.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/target-focus-list.dart';

class TargetFocusListModel extends TargetFocusList {
  const TargetFocusListModel({
    @required int id,
    @required List<IssueModel> targetFocusList,
  }) : super(
          id: id,
          targetFocusList: targetFocusList,
        );

  factory TargetFocusListModel.fromJson(Map<String, dynamic> jsonMap) {
    try {
      final rawTargetFocusList = jsonMap['targetFocusList'] as List;
      return TargetFocusListModel(
        id: jsonMap['id'] as int,
        targetFocusList: rawTargetFocusList
            .map(
              (rawTarget) =>
                  IssueModel.fromJson(rawTarget as Map<String, dynamic>),
            )
            .toList(),
      );
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
