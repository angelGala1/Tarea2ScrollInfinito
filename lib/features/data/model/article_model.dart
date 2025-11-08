import '../../../core/failure/parsear_failure.dart';
import '../../domain/entitie/article_entity.dart';

class ArticleModel {
  final bool typeChange;
  final String title;
  final String shortDescription;
  final bool status;
  final String slug;
  final String urlImage;
  final String createdAt;

  const ArticleModel({
    required this.typeChange,
    required this.title,
    required this.shortDescription,
    required this.status,
    required this.slug,
    required this.urlImage,
    required this.createdAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      typeChange: json['type_change'] as bool? ?? false,
      title: json['title'] as String? ?? '',
      shortDescription: json['short_description'] as String? ?? '',
      status: json['status'] as bool? ?? false,
      slug: json['slug'] as String? ?? '',
      urlImage: json['url_image'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
    );
  }

  ArticleEntity toEntity() {
    return ArticleEntity(
      title: title,
      shortDescription: shortDescription,
      slug: slug,
      urlImage: urlImage,
      createdAt: DateTime.tryParse(createdAt) ?? DateTime.now(),
      status: status,
      typeChange: typeChange,
    );
  }
}