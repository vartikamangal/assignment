// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

class QuestionId extends Equatable {
  final String? id;
  const QuestionId({
    required this.id,
  });
  @override
  List<Object?> get props => [id];

  @override
  bool get stringify => true;
}
