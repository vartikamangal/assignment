// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/subject-information.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../domain/repositories/set-subject-name-service.dart';
import '../sources/set-subject-name-remote-service.dart';

class SetSubjectNameServiceImpl implements SetSubjectNameService {
  final SetSubjectNameRemoteService service;
  final BaseRepository baseRepository;

  SetSubjectNameServiceImpl({
    @required this.service,
    @required this.baseRepository,
  });

  @override
  Future<Either<Failure, SubjectInformation>> setSubjectName({
    String subjectName,
    String deviceId,
  }) async {
    return baseRepository(
      () => service.setSubjectName(name: subjectName),
    );
  }
}
