import 'package:dartz/dartz.dart';

import '../../../error/failures.dart';
import '../../../usecase/usecase.dart';
import '../entities/activity-feedback.dart';
import '../repositories/persist-activity-feedback-repository.dart';

class GetPersistedFeedbacks
    implements Usecase<List<ActivityFeedback>, NoParams> {
  final PersistActivityFeedbackRepository? service;

  GetPersistedFeedbacks({
    required this.service,
  });
  @override
  Future<Either<Failure, List<ActivityFeedback>>> call(NoParams params) async {
    return service!.getpersistedFeedbacks();
  }
}
