import 'package:flutter_test/flutter_test.dart';
import 'package:tatsam_app_experimental/core/app-page-status/data/models/app-route-model.dart';
import 'package:tatsam_app_experimental/core/app-page-status/domain/entities/app-route.dart';

void main() {
  const tAppRoute = AppRouteModel(name: '/test-route');
  group('MODEL: AppRouteModel', () {
    test('is a [AppRoute]', () async {
      //assert
      expect(tAppRoute, isA<AppRoute>());
    });
  });
}
