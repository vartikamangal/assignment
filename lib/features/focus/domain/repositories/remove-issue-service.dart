import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../entities/issue.dart';

abstract class RemoveIssueService {
  Future<Either<Failure, Success>> removeIssue({@required Issue issue});
}
