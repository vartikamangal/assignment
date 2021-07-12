// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:hive/hive.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/persistence-consts.dart';

abstract class RetrieveUserPathLocalDataSource {
  Future<String> retrievePath();
}

class RetrieveUserPathLocalDataSourceImpl
    implements RetrieveUserPathLocalDataSource {
  final Box localClient;

  RetrieveUserPathLocalDataSourceImpl({
    required this.localClient,
  });
  @override
  Future<String> retrievePath() async {
    try {
      final userPath = localClient.get(
        PersistenceConst.USER_SELECTED_PATH,
      ) as String;
      return userPath;
    } catch (e) {
      //TODO user path [Null] error here!!!
      log("BLABLABLA!!!");
      throw CacheException();
    }
  }
}
