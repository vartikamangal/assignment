// Flutter imports:

// Package imports:
import 'package:tatsam_app_experimental/app-config.dart';
import 'package:tatsam_app_experimental/core/analytics/analytics-setup.dart';
import 'package:tatsam_app_experimental/core/env.dart';
import 'package:tatsam_app_experimental/main_common.dart';
import 'package:tatsam_app_experimental/my-app.dart';

// Project imports:
import 'dependency_manager/core_dependency_managers.dart';
import 'setup-my-app.dart';

Future<void> main() async {
  await mainCommon();
  final configureApp = AppConfig(
    appTitle: 'Staging',
    env: Env.staging,
    secrets: const TestSecrets(secretKey: 'this_is_a_test_key_for_staging'),
    child: MyApp(
      analyticsService: sl_core_dependencies<SetupAnalytics>(),
    ),
  );
  setupApp(configureApp);
}
