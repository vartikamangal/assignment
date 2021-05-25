import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/set-user-feeling-service.dart';

class SetSubjectFeeling implements Usecase<Success, SetSubjectFeelingParams> {
  final SetSubjectFeelingService service;
// Change to fellingDesc
  SetSubjectFeeling({@required this.service});
  @override
  Future<Either<Failure, Success>> call(SetSubjectFeelingParams params) async {
    return service.setSubjectFeeling(params.feeling);
  }
}

class SetSubjectFeelingParams extends Equatable {
  final String feeling;

  const SetSubjectFeelingParams({@required this.feeling});
  @override
  List<Object> get props => [feeling];
}
