import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/repositories/clear-dirty-cache-service.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

class ClearDirtyCacheServiceImpl implements ClearDirtyCacheService {
  final FlutterSecureStorage storage;

  ClearDirtyCacheServiceImpl({
    @required this.storage,
  });

  @override
  Future<Either<Failure, Unit>> clearCache() async {
    try {
      log("Clearing all SecureStorage keys and values");
      await storage.deleteAll();
      return const Right(unit);
    } on PlatformException {
      return Left(CacheFailure());
    }
  }
}