// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../domain/entities/life-area.dart';
import '../../domain/repositories/get-life-areas-repository.dart';
import '../sources/get-life-areas-remote-data-source.dart';

class GetLifeAreasRepositoryImpl implements GetLifeAreasRepository {
  final GetLifeAreasRemoteDataSource source;
  final BaseRepository baseRepository;

  GetLifeAreasRepositoryImpl({
    @required this.source,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, List<LifeArea>>> getLifeAreas() async {
    return baseRepository(
      () => source.getAreas(),
    );
  }
}
