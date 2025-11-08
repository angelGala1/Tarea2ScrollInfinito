import 'package:equatable/equatable.dart';

import 'article_entity.dart';

class BannerEntity {
  final String title;
  final String shortDescription;
  final String slug;
  final String urlImage;
  final DateTime createdAt;

  const BannerEntity({
    required this.title,
    required this.shortDescription,
    required this.slug,
    required this.urlImage,
    required this.createdAt,
  });
}