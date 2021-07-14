import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation-category.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/add-weekly-category-service.dart';

class AddWeeklyCategory implements Usecase<Unit, AddWeeklyCategoryParams> {
  final AddWeeklyCategoryService? service;

  AddWeeklyCategory({
    required this.service,
  });
  @override
  Future<Either<Failure, Unit>?> call(AddWeeklyCategoryParams params) async {
    return service!.addWeeklyCategory(
      weekNumber: params.weekNumber,
      category: params.category,
    );
  }
}

class AddWeeklyCategoryParams extends Equatable {
  final int? weekNumber;
  final RecommendationCategory category;
  const AddWeeklyCategoryParams({
    required this.weekNumber,
    required this.category,
  });

  @override
  List<Object?> get props => [weekNumber];
}
