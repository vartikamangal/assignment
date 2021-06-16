// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:equatable/equatable.dart';

class SoSResource extends Equatable {
  final int sosHelplineId;
  final List<String> contactInfos;

  const SoSResource({
    @required this.contactInfos,
    @required this.sosHelplineId,
  });
  @override
  List<Object> get props => [contactInfos, sosHelplineId];
}
