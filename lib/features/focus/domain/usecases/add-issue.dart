import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../entities/issue.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/add-issue-service.dart';

class SetTarget implements Usecase<Success, SetTargetParams> {
  final AddIssueService service;

  SetTarget({@required this.service});
  @override
  Future<Either<Failure, Success>> call(SetTargetParams params) async {
    return service.setTarget(issue: params.issue);
  }
}

class SetTargetParams extends Equatable {
  final Issue issue;

  const SetTargetParams({@required this.issue});
  @override
  List<Object> get props => [issue];
}
