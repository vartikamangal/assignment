import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/hub/domain/repository/create-traveller-service.dart';

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
