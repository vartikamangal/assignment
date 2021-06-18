// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/persistence-consts.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../../domain/entities/success-prioritize.dart';
import '../models/life-area-model-for-prioritization.dart';

abstract class PrioritizeRemoteService {
  Future<SuccessPrioritize> prioritize({
    @required LifeAreaModelForPrioritization lifeAreas,
  });
}

class PrioritizeRemoteServiceImpl implements PrioritizeRemoteService {
  final http.Client client;
  final Box sessionClient;

  PrioritizeRemoteServiceImpl({
    @required this.client,
    @required this.sessionClient,
  });
  @override
  Future<SuccessPrioritize> prioritize({
    @required LifeAreaModelForPrioritization lifeAreas,
  }) async {
    final header = await SessionManager.getHeader();
    final response = await client.post(
      Uri.parse(APIRoute.prioritizeAreas),
      headers: header as Map<String, String>,
      body: jsonEncode(lifeAreas.toJson()),
    );
    await SessionManager.setHeader(header: response.headers);
    if (response.statusCode == 200) {
      return SuccessPrioritize();
    } else {
      throw ServerException();
    }
  }
}
