// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ImageProp extends Equatable {
  final String? url;
  final String? type;

  const ImageProp({
    @required this.type,
    @required this.url,
  });
  @override
  List<Object> get props => [type!, url!];

  ImageProp copyWith({
    String? url,
    String? type,
  }) {
    return ImageProp(
      url: url ?? this.url,
      type: type ?? this.type,
    );
  }

  @override
  bool get stringify => true;
}

class ImagePropModel extends ImageProp {
  const ImagePropModel({
    @required String? iconLocator,
    @required String? iconType,
  }) : super(url: iconLocator, type: iconType);

  factory ImagePropModel.fromJson(Map<String, dynamic> json) {
    return ImagePropModel(
      iconLocator: json['iconLocator'] as String,
      iconType: json['iconType'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "iconLocator": url,
      "iconType": type,
    };
  }
}
