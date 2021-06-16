import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/entities/question-log.dart';
import 'package:tatsam_app_experimental/features/profile-screen/domain/repositories/profile-details-repository.dart';

class GetProfileQuestions implements Usecase<List<QuestionLog>, NoParams> {
  final ProfileDetailsRepository repository;

  GetProfileQuestions({
    @required this.repository,
  });
  @override
  Future<Either<Failure, List<QuestionLog>>> call(NoParams params) async {
    return repository.getProfileQuestions();
  }
}
