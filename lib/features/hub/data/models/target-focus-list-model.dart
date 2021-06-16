// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import '../../../focus/data/models/issue-model.dart';
import '../../domain/entities/target-focus-list.dart';

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
