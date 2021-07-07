// Mocks generated by Mockito 5.0.10 from annotations
// in tatsam_app_experimental/test/features/focus/data/sources/add-issue-remote-service_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:http/src/response.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tatsam_app_experimental/core/data-source/api-client.dart'
    as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeResponse extends _i1.Fake implements _i2.Response {}

/// A class which mocks [ApiClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiClient extends _i1.Mock implements _i3.ApiClient {
  MockApiClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Response> post({String? uri, String? body}) => (super
          .noSuchMethod(Invocation.method(#post, [], {#uri: uri, #body: body}),
              returnValue: Future<_i2.Response>.value(_FakeResponse()))
      as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> get({String? uri}) =>
      (super.noSuchMethod(Invocation.method(#get, [], {#uri: uri}),
              returnValue: Future<_i2.Response>.value(_FakeResponse()))
          as _i4.Future<_i2.Response>);
}
