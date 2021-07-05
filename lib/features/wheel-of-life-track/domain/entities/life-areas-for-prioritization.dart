// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import '../../data/models/life-area-model.dart';

class LifeAreaForPrioritization extends Equatable {
  final List<LifeAreaModel> lifeaAreas;

  const LifeAreaForPrioritization({required this.lifeaAreas});
  @override
  List<Object> get props => [lifeaAreas];
}
