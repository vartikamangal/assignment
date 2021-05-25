import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/persistence-consts.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../models/life-area-model-for-prioritization.dart';
import '../../domain/entities/success-prioritize.dart';
import 'package:http/http.dart' as http;

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
