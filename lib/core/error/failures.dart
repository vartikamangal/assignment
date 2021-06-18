// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class Failure extends Equatable {
  // ignore: avoid_unused_constructor_parameters
  const Failure([List properties = const <dynamic>[]]) : super();
}

class ServerFailure extends Failure {
  @override
  List<Object> get props => [];
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => [];
}

class DeviceOfflineFailure extends Failure {
  @override
  List<Object> get props => [];
}

class FileOperationFailure extends Failure {
  @override
  List<Object> get props => [];
}

class VoiceNoteFailure extends Failure {
  @override
  List<Object> get props => [];
}

class NotPermittedActionFailure extends Failure {
  @override
  List<Object> get props => [];
}

class AuthFailure extends Failure {
  final String code;
  final String smallMessage;
  final String reason;

  const AuthFailure({
    @required this.code,
    @required this.smallMessage,
    @required this.reason,
  });
  @override
  List<Object> get props => [
        reason,
        smallMessage,
        reason,
      ];
}
