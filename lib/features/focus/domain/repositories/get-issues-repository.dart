// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../entities/issue.dart';

abstract class GetIssuesRepository {
  Future<Either<Failure, List<Issue>>> getIssues();
}
