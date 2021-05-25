import 'package:flutter/cupertino.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/routes/api-routes/api-routes.dart';
import 'package:tatsam_app_experimental/core/session-manager/session-manager.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/success-create-traveller.dart';
import 'package:http/http.dart' as http;

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
    SessionManager.setHeader(header: response.headers);
    if (response.statusCode == 200) {
      return const SuccessCreatedTraveller();
    } else {
      throw ServerException();
    }
  }
}
