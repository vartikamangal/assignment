// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../entities/issue.dart';

abstract class AddIssueService {
  Future<Either<Failure, Success>> setTarget({@required Issue issue});
}
