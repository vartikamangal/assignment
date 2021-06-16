// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:equatable/equatable.dart';

class ContactInfo extends Equatable {
  final String
      personName; // This won't be needed as we have created an anonymous user already
  final String contactInfo; // Should we capture it on API for furthur use
  final String email;

  const ContactInfo({
    @required this.personName,
    @required this.contactInfo,
    @required this.email,
  });
  @override
  List<Object> get props => [contactInfo, personName, email];
}
