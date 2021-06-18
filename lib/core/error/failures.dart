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
  final String title;
  final String details;

  const AuthFailure({
    @required this.title,
    @required this.details,
  });
  @override
  List<Object> get props => [
        title,
        details,
      ];
}

class PlaybackFailure extends Failure {
  @override
  List<Object> get props => [];
}

class AnalyticsInitializationFailure extends Failure {
  @override
  List<Object> get props => [];
}
