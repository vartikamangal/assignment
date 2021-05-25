import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class EmergencyNumber extends Equatable {
  final String number;

  const EmergencyNumber({@required this.number});
  @override
  List<Object> get props => [number];
}
