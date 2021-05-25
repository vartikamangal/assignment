import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/life-priority-list.dart';

class LifePrioritiesModel extends LifePriorities {
  const LifePrioritiesModel({
    @required int id,
    @required List<String> areasInOrderOfPriority,
  }) : super(
          areasInOrderOfPriority: areasInOrderOfPriority,
          id: id,
        );

  factory LifePrioritiesModel.fromJson(Map<String, dynamic> jsonMap) {
    try {
      final areasInOrderOfPriorityRaw =
          jsonMap['areasInOrderOfPriority'] as List;
      return LifePrioritiesModel(
        id: jsonMap['id'] as int,
        areasInOrderOfPriority: areasInOrderOfPriorityRaw
            .map(
              (rawPriorityArea) => rawPriorityArea.toString(),
            )
            .toList(),
      );
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
