// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../core/image/image.dart';

class Issue extends Equatable {
  final int? issueId;
  final String? focusName;
  final String? displayName;
  final String? messageOnSelection;
  final ImageEntity? issueIcon;

  const Issue({
    required this.issueId,
    required this.issueIcon,
    required this.displayName,
    required this.focusName,
    required this.messageOnSelection,
  });
  @override
  List<Object?> get props => [
        issueId,
        issueIcon,
        displayName,
        focusName,
        messageOnSelection,
      ];

  @override
  bool get stringify => true;
}
