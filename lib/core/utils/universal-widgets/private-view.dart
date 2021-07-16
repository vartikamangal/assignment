import 'dart:developer';

/// On Screens extending this one
/// Analytics recording service will not be available.
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tatsam_app_experimental/core/analytics/analytics-setup.dart';

import '../../analytics/analytics-setup.dart';

class PrivateView extends StatefulWidget {
  const PrivateView({required this.child});
  final Widget child;
  @override
  _PrivateViewState createState() => _PrivateViewState();
}

class _PrivateViewState extends State<PrivateView> {
  @override
  void initState() {
    log("<--------- Private Screen Called ----------->");
    GetIt.I.get<SetupAnalytics>().disableRendering();
    super.initState();
  }

  @override
  void dispose() {
    log("<--------- Private Screen disposed ----------->");
    GetIt.I.get<SetupAnalytics>().enableRendering();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
