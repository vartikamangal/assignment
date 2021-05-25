import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/life-area.dart';
import '../repositories/get-life-areas-repository.dart';

class GetLifeAreas extends Usecase<List<LifeArea>, NoParams> {
  final GetLifeAreasRepository repository;

  GetLifeAreas({@required this.repository});
  @override
  Future<Either<Failure, List<LifeArea>>> call(NoParams params) async {
    return repository.getLifeAreas();
  }
}
