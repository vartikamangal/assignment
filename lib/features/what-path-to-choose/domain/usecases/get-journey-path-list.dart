import 'package:flutter/cupertino.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../entites/journey.dart';
import '../repositories/get_journey_path_list_repository.dart';

class GetJourneyPathList implements Usecase<List<Journey>, NoParams> {
  final GetJounreyPathListRepository repository;

  GetJourneyPathList({@required this.repository});
  @override
  Future<Either<Failure, List<Journey>>> call(NoParams params) async {
    return repository.getJourneyPaths();
  }
}
