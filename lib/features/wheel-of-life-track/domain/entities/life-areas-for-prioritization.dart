import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../data/models/life-area-model.dart';

class LifeAreaForPrioritization extends Equatable {
  final List<LifeAreaModel> lifeaAreas;

  const LifeAreaForPrioritization({@required this.lifeaAreas});
  @override
  List<Object> get props => [lifeaAreas];
}
