// Flutter imports:
import 'package:flutter/material.dart';

class ResponsiveOrientation extends StatelessWidget {
  final Widget potrait;
  final Widget landscape;

  const ResponsiveOrientation({
    Key key,
    @required this.potrait,
    @required this.landscape,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Orientation _orientation = MediaQuery.of(context).orientation;
    return _orientation == Orientation.landscape ? landscape : potrait;
  }
}
