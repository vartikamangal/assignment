import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class PlayerStats extends Equatable {
  final Duration? totalLength;
  final Duration? currentPosition;
  const PlayerStats({
    required this.totalLength,
    required this.currentPosition,
  });

  @override
  List<Object?> get props => [totalLength, currentPosition];

  @override
  bool get stringify => true;
}
