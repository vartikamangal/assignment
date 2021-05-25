import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../../../../core/persistence-consts.dart';
import '../../../../core/session-manager/session-manager.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../models/mood-model.dart';

abstract class GetAllMoodsRemoteDataSource {
  Future<List<MoodModel>> getMoods();
}

class GetAllMoodsRemoteDataSourceImpl implements GetAllMoodsRemoteDataSource {
  final http.Client client;

  GetAllMoodsRemoteDataSourceImpl({
    @required this.client,
  });
  @override
  Future<List<MoodModel>> getMoods() async {
    final header = await SessionManager.getHeader();
    final response = await client.get(
      Uri.parse(APIRoute.getMoods),
      headers: header as Map<String, String>,
    );
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((moodRaw) => MoodModel.fromJson(moodRaw as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
