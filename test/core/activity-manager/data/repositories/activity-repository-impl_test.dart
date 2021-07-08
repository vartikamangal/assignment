import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/activity/data/repositories/activity-repository-impl.dart';
import 'package:tatsam_app_experimental/core/activity/data/sources/activity-remote-data-source.dart';
import 'package:tatsam_app_experimental/core/platform/network_info.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';
import 'package:tatsam_app_experimental/core/repository/call-if-network-connected.dart';
import 'package:tatsam_app_experimental/core/repository/handle-exception.dart';
import 'activity-repository-impl_test.mocks.dart';

@GenerateMocks([AcitivityRemoteDataSource, NetworkInfo])

void main(){
  ///To generate common mock file for common activity repository
}