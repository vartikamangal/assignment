// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/domain/repositories/wheel-of-life-repository.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/rating-scale.dart';

class GetRatingScale implements Usecase<RatingScale, NoParams> {
  final WheelOfLifeRepository repository;

  GetRatingScale({required this.repository});
  @override
  Future<Either<Failure, RatingScale>?> call(NoParams params) async {
    return repository.getRatingScale();
  }
}
