import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/image/image.dart';

class Issue extends Equatable {
  final int issueId;
  final String focusName;
  final String displayName;
  final String messageOnSelection;
  final ImageProp issueIcon;

  const Issue({
    @required this.issueId,
    @required this.issueIcon,
    @required this.displayName,
    @required this.focusName,
    @required this.messageOnSelection,
  });
  @override
  List<Object> get props => [
        issueId,
        issueIcon,
        displayName,
        focusName,
        messageOnSelection,
      ];

  @override
  bool get stringify => true;
}
