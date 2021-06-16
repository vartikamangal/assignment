import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class AppDuration extends Equatable {
  final DateTime lastLogin;
  final int currentWeekday;
  const AppDuration({
    @required this.lastLogin,
    @required this.currentWeekday,
  });
  @override
  List<Object> get props => [lastLogin, currentWeekday];
}
