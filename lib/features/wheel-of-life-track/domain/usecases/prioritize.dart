import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../entities/life-areas-for-prioritization.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/prioritize-service.dart';

class Prioritize extends Usecase<Success, PrioritizeParams> {
  final PrioritizeService service;

  Prioritize({@required this.service});
  @override
  Future<Either<Failure, Success>> call(PrioritizeParams params) async {
    return service.prioritize(lifeAreas: params.priorities);
  }
}

class PrioritizeParams extends Equatable {
  final LifeAreaForPrioritization priorities;

  const PrioritizeParams({@required this.priorities});
  @override
  List<Object> get props => [priorities];
}
