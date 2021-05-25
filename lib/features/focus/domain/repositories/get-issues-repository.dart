import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/issue.dart';

abstract class GetIssuesRepository {
  Future<Either<Failure, List<Issue>>> getIssues();
}
