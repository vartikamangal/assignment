// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:equatable/equatable.dart';

class Instant extends Equatable {
  final DateTime time;

  const Instant({@required this.time});
  @override
  List<Object> get props => [time];
}
