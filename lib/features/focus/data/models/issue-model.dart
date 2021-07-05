// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import '../../../../core/image/image.dart';
import '../../domain/entities/issue.dart';

class IssueModel extends Issue {
  const IssueModel({
    required int? issueId,
    required String? focusName,
    required String? displayName,
    required String? messageOnSelection,
    required ImageProp? issueIcon,
  }) : super(
          messageOnSelection: messageOnSelection,
          issueIcon: issueIcon,
          issueId: issueId,
          focusName: focusName,
          displayName: displayName,
        );

  factory IssueModel.fromJson(Map<String, dynamic> jsonMap) {
    return IssueModel(
      issueId: jsonMap['id'] as int?,
      focusName: jsonMap['focusName'] as String?,
      displayName: jsonMap['displayName'] as String?,
      messageOnSelection: jsonMap['messageOnSelection'] as String?,
      //TODO To ImageProp.fromJson not Impletemented yet!
      issueIcon: const ImageProp(
        urlLarge: null,
        urlMedium: null,
        urlShort: null,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": issueId,
      "displayName": displayName,
      "messageOnSelection": messageOnSelection,
      "focusName": focusName,
      //TODO To ImageProp.toJson not Impletemented yet!
      "iconVO": null
    };
  }
}
