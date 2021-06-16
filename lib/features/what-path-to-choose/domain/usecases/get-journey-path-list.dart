// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/failures.dart';
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
