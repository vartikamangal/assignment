// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

class EmergencyNumber extends Equatable {
  final String number;

  const EmergencyNumber({@required this.number});
  @override
  List<Object> get props => [number];
}
