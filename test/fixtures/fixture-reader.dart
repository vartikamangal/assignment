// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/cupertino.dart';

String fixtureReader({required String filename}) =>
    File('test/fixtures/$filename').readAsStringSync();
