import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/question-log.dart';
import '../repositories/profile-details-repository.dart';

class GetProfileQuestions implements Usecase<List<QuestionLog>, NoParams> {
  final ProfileDetailsRepository repository;

  GetProfileQuestions({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<QuestionLog>>?> call(NoParams params) async {
    return repository.getProfileQuestions();
  }
}
