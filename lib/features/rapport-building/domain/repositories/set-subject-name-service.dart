// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../entities/subject-information.dart';

abstract class SetSubjectNameService {
  Future<Either<Failure, SubjectInformation>> setSubjectName({
    @required String subjectName,
  });
}
