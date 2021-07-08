import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/recommendation-activity.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/entities/emergency-number.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/entities/instant-relief-area.dart';

abstract class InstantReliefRepository {
  Future<Either<Failure, List<InstantReliefArea>>?> getReliefAreas();
  Future<Either<Failure, List<ActivityRecommendation>>?> getRecommendations({
    required String? instantLifeArea,
  });
  Future<Either<Failure, List<EmergencyNumber>>?> fetchEmergencyNumbers();
}
