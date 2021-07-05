// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/repositories/rapport-building-repository.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/mood.dart';

class GetAllMoods implements Usecase<List<Mood>, NoParams> {
  final RapportBuildingRepository repository;

  GetAllMoods({required this.repository});
  @override
  Future<Either<Failure, List<Mood>>?> call(NoParams params) async {
    return repository.getAllMoods();
  }
}
