// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/issue.dart';
import '../repositories/get-issues-repository.dart';

class GetIssues extends Usecase<List<Issue>, NoParams> {
  final GetIssuesRepository repository;

  GetIssues({@required this.repository});
  @override
  Future<Either<Failure, List<Issue>>> call(NoParams params) async {
    return repository.getIssues();
  }
}
