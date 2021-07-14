import 'dart:developer';

import 'package:http/http.dart' as http;

import '../session-manager/session-manager.dart';

class ApiClient {
  final http.Client? client;

  ApiClient({
    required this.client,
  });
  Future<http.Response> post({
    required String uri,
    String? body,
  }) async {
    final _requestUri = Uri.parse(uri);
    final _requestHeaders = await SessionManager.getHeader();
    log(_requestHeaders.toString());
    log(_requestUri.toString());
    final response = await http.post(
      _requestUri,
      headers: _requestHeaders,
      body: body,
    );
    log(response.headers.toString());
    log(response.body.toString());
    log(response.statusCode.toString());
    await SessionManager.setHeader(header: response.headers);
    return response;
  }

  Future<http.Response> get({
    required String uri,
  }) async {
    final _requestUri = Uri.parse(uri);
    print(_requestUri);
    final _requestHeaders = await SessionManager.getHeader();
    final response = await http.get(
      _requestUri,
      headers: _requestHeaders,
    );
    log(response.headers.toString());
    await SessionManager.setHeader(header: response.headers);
    return response;
  }
}
