import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/mood.dart';
import '../repositories/get-all-moods-repository.dart';

class GetAllMoods implements Usecase<List<Mood>, NoParams> {
  final GetAllMoodsRepository repository;

  GetAllMoods({@required this.repository});
  @override
  Future<Either<Failure, List<Mood>>> call(NoParams params) async {
    return repository.getAllMoods();
  }
}
