import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
