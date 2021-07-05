// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:equatable/equatable.dart';

class Feeling extends Equatable {
  final String? feeling;

  const Feeling({required this.feeling});
  @override
  List<Object?> get props => [feeling];
}
