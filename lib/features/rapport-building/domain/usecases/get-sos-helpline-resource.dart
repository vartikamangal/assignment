import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/sos-resource.dart';
import '../repositories/get-sos-helpline-resource_repository.dart';

class GetSoSHelplineResource extends Usecase<SoSResource, NoParams> {
  final GetSOSResourceReporsitory repository;

  GetSoSHelplineResource({@required this.repository});
  @override
  Future<Either<Failure, SoSResource>> call(NoParams params) async {
    return repository.getSosResource();
  }
}
