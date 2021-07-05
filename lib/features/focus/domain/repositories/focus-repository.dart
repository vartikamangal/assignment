import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';
import 'package:tatsam_app_experimental/features/focus/domain/entities/issue.dart';

abstract class FocusRepository {
  Future<Either<Failure, List<Issue>>?> getIssues();
  Future<Either<Failure, Success>?> setTarget({required Issue? issue});
  Future<Either<Failure, Success>?> removeIssue({required Issue issue});
}
