// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/repositories/wheel-of-life-repository.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/life-area.dart';

class GetLifeAreas extends Usecase<List<LifeArea>, NoParams> {
  final WheelOfLifeRepository repository;

  GetLifeAreas({required this.repository});
  @override
  Future<Either<Failure, List<LifeArea>>?> call(NoParams params) async {
    return repository.getLifeAreas();
  }
}
