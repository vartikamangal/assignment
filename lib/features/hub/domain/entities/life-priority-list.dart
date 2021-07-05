// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:equatable/equatable.dart';

class LifePriorities extends Equatable {
  final int? id;
  final List<String> areasInOrderOfPriority;

  const LifePriorities({
    required this.id,
    required this.areasInOrderOfPriority,
  });
  @override
  List<Object?> get props => [id, areasInOrderOfPriority];

  LifePriorities copyWith({
    int? id,
    List<String>? areasInOrderOfPriority,
  }) {
    return LifePriorities(
      id: id ?? this.id,
      areasInOrderOfPriority:
          areasInOrderOfPriority ?? this.areasInOrderOfPriority,
    );
  }

  @override
  bool get stringify => true;
}
