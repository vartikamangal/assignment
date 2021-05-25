import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../entities/contact-info.dart';

abstract class RequestInstantContactService {
  Future<Either<Failure, Success>> requestInstantContactService({
    @required ContactInfo contactInfo,
  });
}
