import '../../../../core/failure/failure.dart';
import '../../../domain/entitie/article_entity.dart';
import '../../../domain/entitie/article_response_entity.dart';

import '../../../domain/entitie/banner_entity.dart';


abstract class ArticleState {
  const ArticleState();
}

class ArticleInitial extends ArticleState {
  const ArticleInitial();
}

class ArticleLoading extends ArticleState {
  const ArticleLoading();
}

class ArticleLoaded extends ArticleState {
  final BannerEntity banner;
  final List<ArticleEntity> articles;
  final int currentPage;
  final int totalPages;
  final bool isLoadingMore;

  const ArticleLoaded({
    required this.banner,
    required this.articles,
    required this.currentPage,
    required this.totalPages,
    this.isLoadingMore = false,
  });

  bool get hasMorePages => currentPage < totalPages;

  ArticleLoaded copyWith({
    BannerEntity? banner,
    List<ArticleEntity>? articles,
    int? currentPage,
    int? totalPages,
    bool? isLoadingMore,

  }) {
    return ArticleLoaded(
      banner: banner ?? this.banner,
      articles: articles ?? this.articles,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class ArticleError extends ArticleState {
  final Failure failure;

  const ArticleError(this.failure);

  String get errorMessage => failure.message;
}