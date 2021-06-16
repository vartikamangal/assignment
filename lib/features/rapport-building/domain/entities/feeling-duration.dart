// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:equatable/equatable.dart';

class FeelingDuration extends Equatable {
  final String durationName;
  final String durationSequence;
  final String durationDisplayName;

  const FeelingDuration({
    @required this.durationName,
    @required this.durationSequence,
    @required this.durationDisplayName,
  });
  @override
  List<Object> get props => [
        durationName,
        durationSequence,
        durationDisplayName,
      ];

  @override
  bool get stringify => true;
}
