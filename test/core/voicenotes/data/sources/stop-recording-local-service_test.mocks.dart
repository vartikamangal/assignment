// Mocks generated by Mockito 5.0.10 from annotations
// in tatsam_app_experimental/test/core/voicenotes/data/source/stop-recording-local-service_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;
import 'dart:typed_data' as _i4;

import 'package:flutter_sound/public/flutter_sound_recorder.dart' as _i2;
import 'package:flutter_sound/public/tau.dart' as _i7;
import 'package:flutter_sound_platform_interface/flutter_sound_platform_interface.dart'
    as _i6;
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [FlutterSoundRecorder].
///
/// See the documentation for Mockito's code generation for more information.
class MockFlutterSoundRecorder extends _i1.Mock
    implements _i2.FlutterSoundRecorder {
  MockFlutterSoundRecorder() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.RecorderState get recorderState =>
      (super.noSuchMethod(Invocation.getter(#recorderState),
          returnValue: _i3.RecorderState.isStopped) as _i3.RecorderState);
  @override
  bool get isRecording =>
      (super.noSuchMethod(Invocation.getter(#isRecording), returnValue: false)
          as bool);
  @override
  bool get isStopped =>
      (super.noSuchMethod(Invocation.getter(#isStopped), returnValue: false)
          as bool);
  @override
  bool get isPaused =>
      (super.noSuchMethod(Invocation.getter(#isPaused), returnValue: false)
          as bool);
  @override
  void recordingData({_i4.Uint8List? data}) =>
      super.noSuchMethod(Invocation.method(#recordingData, [], {#data: data}),
          returnValueForMissingStub: null);
  @override
  void updateRecorderProgress({int? duration, double? dbPeakLevel}) =>
      super.noSuchMethod(
          Invocation.method(#updateRecorderProgress, [],
              {#duration: duration, #dbPeakLevel: dbPeakLevel}),
          returnValueForMissingStub: null);
  @override
  void openRecorderCompleted(int? state, bool? success) => super.noSuchMethod(
      Invocation.method(#openRecorderCompleted, [state, success]),
      returnValueForMissingStub: null);
  @override
  void closeRecorderCompleted(int? state, bool? success) => super.noSuchMethod(
      Invocation.method(#closeRecorderCompleted, [state, success]),
      returnValueForMissingStub: null);
  @override
  void pauseRecorderCompleted(int? state, bool? success) => super.noSuchMethod(
      Invocation.method(#pauseRecorderCompleted, [state, success]),
      returnValueForMissingStub: null);
  @override
  void resumeRecorderCompleted(int? state, bool? success) => super.noSuchMethod(
      Invocation.method(#resumeRecorderCompleted, [state, success]),
      returnValueForMissingStub: null);
  @override
  void startRecorderCompleted(int? state, bool? success) => super.noSuchMethod(
      Invocation.method(#startRecorderCompleted, [state, success]),
      returnValueForMissingStub: null);
  @override
  void stopRecorderCompleted(int? state, bool? success, String? url) =>
      super.noSuchMethod(
          Invocation.method(#stopRecorderCompleted, [state, success, url]),
          returnValueForMissingStub: null);
  @override
  _i5.Future<_i2.FlutterSoundRecorder?> openAudioSession(
          {_i6.AudioFocus? focus = _i6.AudioFocus.requestFocusTransient,
          _i6.SessionCategory? category = _i6.SessionCategory.playAndRecord,
          _i6.SessionMode? mode = _i6.SessionMode.modeDefault,
          int? audioFlags = 1,
          _i6.AudioDevice? device = _i6.AudioDevice.speaker}) =>
      (super.noSuchMethod(
              Invocation.method(#openAudioSession, [], {
                #focus: focus,
                #category: category,
                #mode: mode,
                #audioFlags: audioFlags,
                #device: device
              }),
              returnValue: Future<_i2.FlutterSoundRecorder?>.value())
          as _i5.Future<_i2.FlutterSoundRecorder?>);
  @override
  _i5.Future<void> closeAudioSession() =>
      (super.noSuchMethod(Invocation.method(#closeAudioSession, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i5.Future<void>);
  @override
  _i5.Future<bool> isEncoderSupported(_i6.Codec? codec) =>
      (super.noSuchMethod(Invocation.method(#isEncoderSupported, [codec]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  _i5.Future<void> setSubscriptionDuration(Duration? duration) => (super
      .noSuchMethod(Invocation.method(#setSubscriptionDuration, [duration]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i5.Future<void>);
  @override
  _i5.Future<void> startRecorder(
          {_i6.Codec? codec = _i6.Codec.defaultCodec,
          String? toFile,
          _i5.StreamSink<_i7.Food>? toStream,
          int? sampleRate = 16000,
          int? numChannels = 1,
          int? bitRate = 16000,
          _i3.AudioSource? audioSource = _i3.AudioSource.defaultSource}) =>
      (super.noSuchMethod(
          Invocation.method(#startRecorder, [], {
            #codec: codec,
            #toFile: toFile,
            #toStream: toStream,
            #sampleRate: sampleRate,
            #numChannels: numChannels,
            #bitRate: bitRate,
            #audioSource: audioSource
          }),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i5.Future<void>);
  @override
  _i5.Future<String?> stopRecorder() =>
      (super.noSuchMethod(Invocation.method(#stopRecorder, []),
          returnValue: Future<String?>.value()) as _i5.Future<String?>);
  @override
  _i5.Future<void> setAudioFocus(
          {_i6.AudioFocus? focus = _i6.AudioFocus.requestFocusTransient,
          _i6.SessionCategory? category = _i6.SessionCategory.playAndRecord,
          _i6.SessionMode? mode = _i6.SessionMode.modeDefault,
          _i6.AudioDevice? device = _i6.AudioDevice.speaker}) =>
      (super.noSuchMethod(
          Invocation.method(#setAudioFocus, [], {
            #focus: focus,
            #category: category,
            #mode: mode,
            #device: device
          }),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i5.Future<void>);
  @override
  _i5.Future<void> pauseRecorder() =>
      (super.noSuchMethod(Invocation.method(#pauseRecorder, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i5.Future<void>);
  @override
  _i5.Future<void> resumeRecorder() =>
      (super.noSuchMethod(Invocation.method(#resumeRecorder, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i5.Future<void>);
  @override
  _i5.Future<bool?> deleteRecord({String? fileName}) => (super.noSuchMethod(
      Invocation.method(#deleteRecord, [], {#fileName: fileName}),
      returnValue: Future<bool?>.value()) as _i5.Future<bool?>);
  @override
  _i5.Future<String?> getRecordURL({String? path}) =>
      (super.noSuchMethod(Invocation.method(#getRecordURL, [], {#path: path}),
          returnValue: Future<String?>.value()) as _i5.Future<String?>);
}
