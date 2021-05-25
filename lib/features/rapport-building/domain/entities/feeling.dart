import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Feeling extends Equatable {
  final String feeling;

  const Feeling({@required this.feeling});
  @override
  List<Object> get props => [feeling];
}
