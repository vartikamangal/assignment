// Mocks generated by Mockito 5.0.10 from annotations
// in tatsam_app_experimental/test/core/activity-manager/domain/usecases/update-activity-status_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:dartz/dartz.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/activity-status.dart'
    as _i6;
import 'package:tatsam_app_experimental/core/activity-management/domain/repositories/update-activity-status-service.dart'
    as _i2;
import 'package:tatsam_app_experimental/core/error/failures.dart' as _i5;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [UpdateActivityStatusService].
///
/// See the documentation for Mockito's code generation for more information.
class MockUpdateActivityStatusService extends _i1.Mock
    implements _i2.UpdateActivityStatusService {
  MockUpdateActivityStatusService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.Either<_i5.Failure, _i6.ActivityStatus>?> updateStatus(
          {String? status, int? actionId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #updateStatus, [], {#status: status, #actionId: actionId}),
              returnValue:
                  Future<_i4.Either<_i5.Failure, _i6.ActivityStatus>?>.value())
          as _i3.Future<_i4.Either<_i5.Failure, _i6.ActivityStatus>?>);
}
