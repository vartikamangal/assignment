// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/models/instant-relief-area-model.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/entities/instant-relief-area.dart';
import '../../../../fixtures/fixture-reader.dart';

void main() {
  final List<InstantReliefArea> tInstantReliefAreaModel =
      <InstantReliefAreaModel>[
    InstantReliefAreaModel(
      id: 1,
      title: "title",
      subtitle: "subtitle",
      instantReliefName: "instantReliefName",
      description: "description",
      icon: null,
    )
  ];
  group('Model InstantReliefAreaModel ', () {
    test('should be an extendor of Feeling', () async {
      //assert
      expect(tInstantReliefAreaModel.first, isA<InstantReliefArea>());
    });
  });
}
