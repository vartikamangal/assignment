import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class AppRoute extends Equatable {
  final String name;

  const AppRoute({
    @required this.name,
  });

  @override
  List<Object> get props => [name];
}
