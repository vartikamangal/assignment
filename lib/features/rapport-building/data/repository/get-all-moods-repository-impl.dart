// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../domain/entities/mood.dart';
import '../../domain/repositories/get-all-moods-repository.dart';
import '../sources/get-all-moods-remote-data-source.dart';

class GetAllMoodsRepositoryImpl implements GetAllMoodsRepository {
  final GetAllMoodsRemoteDataSource source;
  final BaseRepository baseRepository;

  GetAllMoodsRepositoryImpl({
    @required this.source,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, List<Mood>>> getAllMoods() async {
    return baseRepository(() => source.getMoods());
  }
}
