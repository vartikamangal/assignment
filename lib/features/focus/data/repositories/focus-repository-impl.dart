import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';
import 'package:tatsam_app_experimental/features/focus/data/sources/focus-remote-data-source.dart';
import 'package:tatsam_app_experimental/features/focus/domain/entities/issue.dart';
import 'package:tatsam_app_experimental/features/focus/domain/repositories/focus-repository.dart';

class FocusRepositoryImpl extends FocusRepository {
  final BaseRepository baseRepository;
  final FocusRemoteDataSource? remoteDataSource;

  FocusRepositoryImpl({
    required this.baseRepository,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, List<Issue>>?> getIssues() async {
    return baseRepository(
      () => remoteDataSource!.getIssues(),
    );
  }

  @override
  Future<Either<Failure, Success>?> removeIssue({Issue? issue}) async {
    return baseRepository(
      () => remoteDataSource!.removeIssue(issue: issue),
    );
  }

  @override
  Future<Either<Failure, Success>?> setTarget({Issue? issue}) async {
    return baseRepository(
      () => remoteDataSource!.addIssue(issue: issue),
    );
  }
}
