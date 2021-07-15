// Package imports:
import 'package:tatsam_app_experimental/features/view-all-content/data/models/data-model.dart';
import 'package:tatsam_app_experimental/features/view-all-content/domain/entities/entity.dart';

const String fallbackIconUrl = "https://images.tatsam.in/Logo+512+x+512.png";
const String fallbackIconType = "png";

// can't keep name as Image as it conflicts with flutter's "Image" widget
class ImageEntity extends Entity {
  final String url;
  final String type;

  ImageEntity({
    required this.type,
    required this.url,
  });

  ImageEntity copyWith({
    String? url,
    String? type,
  }) {
    return ImageEntity(
      url: url ?? this.url,
      type: type ?? this.type,
    );
  }
}

class ImageModel extends DataModel<ImageEntity> {
  String? iconLocator;
  String? iconType;

  ImageModel({required this.iconLocator, required this.iconType});

  ImageModel.fromJson(Map<String, dynamic> json)
      : iconLocator = json['iconLocator'] as String,
        iconType = json['iconType'] as String;

  ImageModel.fromDomain(ImageEntity image)
      : iconLocator = image.url,
        iconType = image.type;

  @override
  Map<String, dynamic> toJson() {
    // This thing giving Auth Error while Adding Focus
    // return {
    //   "iconLocator": iconLocator,
    //   "iconType": iconType,
    // };
    return {};
  }

  ImageModel.fallbackIcon()
      : iconLocator = fallbackIconUrl,
        iconType = fallbackIconType;

  @override
  ImageEntity toDomain() {
    return ImageEntity(
      type: iconType ?? fallbackIconType,
      url: iconLocator ?? fallbackIconUrl,
    );
  }
}
