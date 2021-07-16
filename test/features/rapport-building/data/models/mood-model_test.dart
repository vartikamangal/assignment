// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood.dart';
import '../../../../fixtures/fixture-reader.dart';

void main() {
  final tMoodModel = MoodModel(
    id: 1,
    moodName: 'VERY_BAD',
    moodDescription: 'Very sad',
    icon: null,
  );

  group('MODEL MoodModel ', () {
    test('should be a extended version of Mood', () async {
      //assert
      expect(tMoodModel, isA<Mood>());
    });
  });
}
