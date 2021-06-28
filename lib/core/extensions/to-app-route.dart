import 'package:tatsam_app_experimental/core/app-page-status/data/models/app-route-model.dart';

extension ToAppRouteModelX on String {
  AppRouteModel makeAppRoute() => AppRouteModel(name: this);
}
