// Mocks generated by Mockito 5.0.10 from annotations
// in tatsam_app_experimental/test/core/cache-management/data/repositories/retrieve-user-path-repository-impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:tatsam_app_experimental/core/cache-manager/data/services/retrieve-user-path-local-data-source.dart'
    as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [RetrieveUserPathLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockRetrieveUserPathLocalDataSource extends _i1.Mock
    implements _i2.RetrieveUserPathLocalDataSource {
  MockRetrieveUserPathLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<String> retrievePath() =>
      (super.noSuchMethod(Invocation.method(#retrievePath, []),
          returnValue: Future<String>.value('')) as _i3.Future<String>);
}
