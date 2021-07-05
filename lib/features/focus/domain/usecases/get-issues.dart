// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/features/focus/domain/repositories/focus-repository.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/issue.dart';

class GetIssues extends Usecase<List<Issue>, NoParams> {
  final FocusRepository repository;

  GetIssues({required this.repository});
  @override
  Future<Either<Failure, List<Issue>>?> call(NoParams params) async {
    return repository.getIssues();
  }
}
