import 'package:mockito/annotations.dart';
import 'package:tatsam_app_experimental/core/auth/domain/repositories/auth-repository.dart';
import 'package:tatsam_app_experimental/core/data-source/api-client.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';

@GenerateMocks([NetworkInfo, ApiClient, AuthRepository])
void main() {}
