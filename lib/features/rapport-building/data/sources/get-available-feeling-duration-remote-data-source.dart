import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../models/feeling-duration-model.dart';
import 'package:http/http.dart' as http;

abstract class GetAvailableFeelingDurationRemoteDataSource {
  Future<List<FeelingDurationModel>> getAvailableDurations();
}

class GetAvailableFeelingDurationRemoteDataSourceImpl
    implements GetAvailableFeelingDurationRemoteDataSource {
  final http.Client client;

  GetAvailableFeelingDurationRemoteDataSourceImpl({
    @required this.client,
  });
  @override
  Future<List<FeelingDurationModel>> getAvailableDurations() async {
    final header = await SessionManager.getHeader();
    final response = await client.get(
      Uri.parse(APIRoute.getDurationOptions),
      headers: header as Map<String, String>,
    );
    if (response.statusCode == 200) {
      final rawDurationList = jsonDecode(response.body) as List;
      return rawDurationList
          .map(
            (rawDuration) => FeelingDurationModel.fromJson(
                rawDuration as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw ServerException();
    }
  }
}
