import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Instant extends Equatable {
  final DateTime time;

  const Instant({@required this.time});
  @override
  List<Object> get props => [time];
}
