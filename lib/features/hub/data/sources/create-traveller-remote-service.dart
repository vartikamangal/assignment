// Flutter imports:
import 'dart:developer';

import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/api-routes/api-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../../domain/entities/success-create-traveller.dart';

abstract class CreateTravellerRemoteService {
  Future<SuccessCreatedTraveller> createTraveller();
}

class CreateTravellerRemoteServiceImpl implements CreateTravellerRemoteService {
  final http.Client client;

  CreateTravellerRemoteServiceImpl({
    @required this.client,
  });
  @override
  Future<SuccessCreatedTraveller> createTraveller() async {
    final header = await SessionManager.getHeader();
    final response = await client.get(
      Uri.parse(APIRoute.createNewTraveller),
      headers: header,
    );

    await SessionManager.setHeader(header: response.headers);
    log(response.body);
    log(response.statusCode.toString());
    log(header.toString());
    if (response.statusCode == 200) {
      return const SuccessCreatedTraveller();
    } else {
      log(response.body);
      throw ServerException();
    }
  }
}
