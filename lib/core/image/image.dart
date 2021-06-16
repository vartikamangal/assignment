// Package imports:
import 'package:equatable/equatable.dart';

class ImageProp extends Equatable {
  final String urlShort;
  final String urlMedium;
  final String urlLarge;

  const ImageProp({this.urlShort, this.urlMedium, this.urlLarge});
  @override
  List<Object> get props => [urlShort, urlMedium, urlLarge];
}
