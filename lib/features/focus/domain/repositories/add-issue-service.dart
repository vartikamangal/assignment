import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../entities/issue.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';

abstract class AddIssueService {
  Future<Either<Failure, Success>> setTarget({@required Issue issue});
}
