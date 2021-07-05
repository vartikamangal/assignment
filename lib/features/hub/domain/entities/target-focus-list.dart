// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../focus/domain/entities/issue.dart';

class TargetFocusList extends Equatable {
  final int? id;
  final List<Issue> targetFocusList;

  const TargetFocusList({
    required this.id,
    required this.targetFocusList,
  });
  @override
  List<Object?> get props => [id, targetFocusList];

  @override
  bool get stringify => true;

  TargetFocusList copyWith({
    int? id,
    List<Issue>? targetFocusList,
  }) {
    return TargetFocusList(
      id: id ?? this.id,
      targetFocusList: targetFocusList ?? this.targetFocusList,
    );
  }
}
