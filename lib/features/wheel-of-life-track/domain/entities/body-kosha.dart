import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class BodyKosha extends Equatable {
  final String koshaCode;
  final String name;
  final String description;

  const BodyKosha({
    @required this.koshaCode,
    @required this.name,
    @required this.description,
  });

  @override
  List<Object> get props => [koshaCode, name, description];
}
