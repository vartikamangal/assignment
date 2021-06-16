// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/create-traveller-service.dart';

class CreateTraveller implements Usecase<Success, NoParams> {
  final CreateTravellerService service;

  CreateTraveller({
    @required this.service,
  });
  @override
  Future<Either<Failure, Success>> call(NoParams params) async {
    return service.createTraveller();
  }
}
