// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../core/platform/instant.dart';

class Age extends Equatable {
  final int age;
  final Instant when;

  const Age({
    @required this.age,
    @required this.when,
  });
  @override
  List<Object> get props => [age, when];
}
