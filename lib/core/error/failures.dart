import 'package:equatable/equatable.dart';

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
