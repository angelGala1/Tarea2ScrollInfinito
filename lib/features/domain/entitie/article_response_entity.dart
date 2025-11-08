import 'article_entity.dart';
import 'banner_entity.dart';

class ArticleResponseEntity {
  final bool error;
  final int status;
  final String message;
  final BannerEntity banner;
  final List<ArticleEntity> articles;
  final int total;
  final int rows;
  final int from;
  final int to;
  final int pages;
  final int pageSelected;

  const ArticleResponseEntity({
    required this.error,
    required this.status,
    required this.message,
    required this.banner,
    required this.articles,
    required this.total,
    required this.rows,
    required this.from,
    required this.to,
    required this.pages,
    required this.pageSelected,
  });

  bool get hasMorePages => pageSelected < pages;
}