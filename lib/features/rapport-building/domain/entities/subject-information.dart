// Flutter imports:
// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'subject-id.dart';

// ignore: constant_identifier_names
enum Gender { Male, Female }

class SubjectInformation extends Equatable {
  final SubjectId? subjectId;
  final String? userID;
  final String? name;
  final String? nickName;
  final String? deviceIndentifier;
  final Gender? gender;

  const SubjectInformation({
    this.subjectId,
    this.userID,
    required this.name,
    required this.deviceIndentifier,
    this.gender,
    this.nickName,
  });
  @override
  List<Object?> get props {
    return [
      subjectId,
      userID,
      name,
      nickName,
      deviceIndentifier,
      gender,
    ];
  }
}
