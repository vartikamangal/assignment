import 'package:freezed_annotation/freezed_annotation.dart';

part 'env.freezed.dart';

@freezed
class Environment with _$Environment {
  const factory Environment.prod() = Prod;
  const factory Environment.staging() = Staging;
  const factory Environment.dev() = Dev;
}
