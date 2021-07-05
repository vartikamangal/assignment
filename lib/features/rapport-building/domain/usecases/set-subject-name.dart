// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/subject-information.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/repositories/rapport-building-repository.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

class SetSubjectName extends Usecase<SubjectInformation, SetSubjectNameParams> {
  final RapportBuildingRepository service;

  SetSubjectName({required this.service});
  @override
  Future<Either<Failure, SubjectInformation>?> call(
      SetSubjectNameParams params) async {
    return service.setSubjectName(
      subjectName: params.name,
    );
  }
}

class SetSubjectNameParams extends Equatable {
  final String name;

  const SetSubjectNameParams({
    required this.name,
  });
  @override
  List<Object> get props => [name];
}
