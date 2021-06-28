// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/subject-information.dart';

// Project imports:
import '../../../../core/error/failures.dart';

abstract class SetSubjectNameService {
  Future<Either<Failure, SubjectInformation>> setSubjectName({
    @required String subjectName,
  });
}
