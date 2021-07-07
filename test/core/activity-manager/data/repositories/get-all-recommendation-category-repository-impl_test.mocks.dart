// Mocks generated by Mockito 5.0.10 from annotations
// in tatsam_app_experimental/test/core/activity-manager/data/repositories/get-all-recommendation-category-repository-impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:tatsam_app_experimental/core/activity-management/data/models/recommendation-category-model.dart'
    as _i4;
import 'package:tatsam_app_experimental/core/activity-management/data/sources/get-all-recommendation-categories-remote-data-source.dart'
    as _i2;
import 'package:tatsam_app_experimental/core/platform/network_info.dart' as _i5;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [GetAllRecommendationCategoriesRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetAllRecommendationCategoriesRemoteDataSource extends _i1.Mock
    implements _i2.GetAllRecommendationCategoriesRemoteDataSource {
  MockGetAllRecommendationCategoriesRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.RecommendationCategoryModel>> getAllCategories() =>
      (super.noSuchMethod(Invocation.method(#getAllCategories, []),
              returnValue: Future<List<_i4.RecommendationCategoryModel>>.value(
                  <_i4.RecommendationCategoryModel>[]))
          as _i3.Future<List<_i4.RecommendationCategoryModel>>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i5.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
}
