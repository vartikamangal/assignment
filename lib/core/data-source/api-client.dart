import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../session-manager/session-manager.dart';

class ApiClient {
  final http.Client client;

  ApiClient({
    @required this.client,
  });
  Future<http.Response> post({
    @required String uri,
    String body,
  }) async {
    final _requestUri = Uri.parse(uri);
    final _requestHeaders = await SessionManager.getHeader();
    final response = await http.post(
      _requestUri,
      headers: _requestHeaders,
      body: body,
    );
    log(response.headers.toString());
    log(response.toString());
    await SessionManager.setHeader(header: response.headers);
    return response;
  }

  Future<http.Response> get({
    @required String uri,
  }) async {
    final _requestUri = Uri.parse(uri);
    final _requestHeaders = await SessionManager.getHeader();
    log(_requestHeaders.toString());
    final response = await http.get(
      _requestUri,
      headers: _requestHeaders,
    );
    log(response.toString());
    await SessionManager.setHeader(header: response.headers);
    return response;
  }
}
