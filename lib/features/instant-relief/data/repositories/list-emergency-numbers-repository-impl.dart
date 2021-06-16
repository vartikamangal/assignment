// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../domain/entities/emergency-number.dart';
import '../../domain/repositories/list-emergency-numbers-repository.dart';
import '../sources/list-emergency-numbers-remote-service.dart';

class ListEmergencyNumbersRepositoryImpl
    implements ListEmergencyNumbersRepository {
  final ListEmergencyNumberRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  ListEmergencyNumbersRepositoryImpl({
    @required this.remoteDataSource,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, List<EmergencyNumber>>> fetchEmergencyNumbers() async {
    return baseRepository(
      () => remoteDataSource.fetchEmergencyNumbers(),
    );
  }
}
