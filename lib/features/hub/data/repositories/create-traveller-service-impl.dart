// Flutter imports:
// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../../domain/repository/create-traveller-service.dart';
import '../sources/create-traveller-remote-service.dart';

class CreateTravellerServiceImpl implements CreateTravellerService {
  final CreateTravellerRemoteService? remoteService;
  final BaseRepository baseRepository;

  CreateTravellerServiceImpl({
    required this.remoteService,
    required this.baseRepository,
  });
  @override
  Future<Either<Failure, Success>?> createTraveller() async {
    return baseRepository(
      () => remoteService!.createTraveller(),
    );
  }
}
