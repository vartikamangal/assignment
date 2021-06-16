// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:equatable/equatable.dart';

class LifeArea extends Equatable {
  final String areaCode;
  final String name;
  final String description;

  const LifeArea({
    @required this.areaCode,
    @required this.name,
    @required this.description,
  });

  @override
  List<Object> get props => [areaCode, name, description];
}
