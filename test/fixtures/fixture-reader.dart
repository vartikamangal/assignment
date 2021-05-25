import 'dart:io';

import 'package:flutter/cupertino.dart';

String fixtureReader({@required String filename}) =>
    File('test/fixtures/$filename').readAsStringSync();
