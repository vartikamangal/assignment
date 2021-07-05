// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tatsam_app_experimental/features/focus/domain/repositories/focus-repository.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/issue.dart';

class RemoveIssue implements Usecase<Success, RemoveIssueParams> {
  final FocusRepository service;

  RemoveIssue({required this.service});
  @override
  Future<Either<Failure, Success>?> call(RemoveIssueParams params) async {
    return service.removeIssue(issue: params.issue);
  }
}

class RemoveIssueParams extends Equatable {
  final Issue issue;

  const RemoveIssueParams({required this.issue});
  @override
  List<Object> get props => [issue];
}
