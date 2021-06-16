// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../domain/entities/subject-information.dart';
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
