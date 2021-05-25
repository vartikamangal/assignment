import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failures.dart';
import '../entities/subject-information.dart';

abstract class SetSubjectNameService {
  Future<Either<Failure, SubjectInformation>> setSubjectName({
    @required String subjectName,
  });
}
