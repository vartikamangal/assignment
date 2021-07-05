import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/error/failures.dart';

import '../../../../core/usecase/usecase.dart';
import '../repositories/add-weekly-category-service.dart';

class AddWeeklyActivity implements Usecase<Unit, AddWeeklyActivityParams> {
  final AddWeeklyCategoryService? service;

  AddWeeklyActivity({
    required this.service,
  });
  @override
  Future<Either<Failure, Unit>?> call(AddWeeklyActivityParams params) async {
    return service!.addWeeklyActivity(
      category: params.category,
      recommendationId: params.recommendationId,
    );
  }
}

class AddWeeklyActivityParams extends Equatable {
  final String? recommendationId;
  final String category;
  const AddWeeklyActivityParams({
    required this.category,
    required this.recommendationId,
  });
  @override
  List<Object?> get props => [
        recommendationId,
        category,
      ];

  @override
  bool get stringify => true;
}
