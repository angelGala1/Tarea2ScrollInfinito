import '../../../domain/entitie/article_response_entity.dart';
import '../article_model.dart';
import '../banner_model.dart';

class ArticleResponseModel {
  final bool error;
  final int status;
  final String message;
  final BannerModel banner;
  final List<ArticleModel> data;
  final int total;
  final int rows;
  final int from;
  final int to;
  final int pages;
  final int pageSelected;

  const ArticleResponseModel({
    required this.error,
    required this.status,
    required this.message,
    required this.banner,
    required this.data,
    required this.total,
    required this.rows,
    required this.from,
    required this.to,
    required this.pages,
    required this.pageSelected,
  });

  factory ArticleResponseModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataList = json['data'] as List<dynamic>? ?? [];
    final bannerJson = json['banner'] as Map<String, dynamic>? ?? {};

    return ArticleResponseModel(
      error: json['error'] as bool? ?? false,
      status: json['status'] as int? ?? 0,
      message: json['message'] as String? ?? '',
      banner: BannerModel.fromJson(bannerJson),
      data: dataList
          .map((item) => ArticleModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int? ?? 0,
      rows: json['rows'] as int? ?? 0,
      from: json['from'] as int? ?? 0,
      to: json['to'] as int? ?? 0,
      pages: json['pages'] as int? ?? 0,
      pageSelected: json['pageSelected'] as int? ?? 1,
    );
  }

  ArticleResponseEntity toEntity() {
    return ArticleResponseEntity(
      error: error,
      status: status,
      message: message,
      banner: banner.toEntity(),
      articles: data.map((model) => model.toEntity()).toList(),
      total: total,
      rows: rows,
      from: from,
      to: to,
      pages: pages,
      pageSelected: pageSelected,
    );
  }
}
