import '../../../core/failure/parsear_failure.dart';
import '../../domain/entitie/banner_entity.dart';
import 'article_model.dart';


class BannerModel {
  final String title;
  final String shortDescription;
  final String slug;
  final String urlImage;
  final String createdAt;

  const BannerModel({
    required this.title,
    required this.shortDescription,
    required this.slug,
    required this.urlImage,
    required this.createdAt,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      title: json['title'] as String? ?? '',
      shortDescription: json['short_description'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      urlImage: json['url_image'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
    );
  }

  BannerEntity toEntity() {
    return BannerEntity(
      title: title,
      shortDescription: shortDescription,
      slug: slug,
      urlImage: urlImage,
      createdAt: DateTime.tryParse(createdAt) ?? DateTime.now(),
    );
  }
}