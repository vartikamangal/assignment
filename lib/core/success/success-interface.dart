import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class Success extends Equatable {
  final String message;

  const Success({@required this.message});

  @override
  List<Object> get props => [message];
}
