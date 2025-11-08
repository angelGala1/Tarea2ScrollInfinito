import 'package:equatable/equatable.dart';

class ArticleEntity {
  final String title;
  final String shortDescription;
  final String slug;
  final String urlImage;
  final DateTime createdAt;
  final bool status;
  final bool typeChange;

  const ArticleEntity({
    required this.title,
    required this.shortDescription,
    required this.slug,
    required this.urlImage,
    required this.createdAt,
    required this.status,
    required this.typeChange,
  });
}