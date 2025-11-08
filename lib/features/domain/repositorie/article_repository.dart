import '../../../core/failure/failure.dart';
import '../entitie/article_response_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ArticleRepository {
  Future<Either<Failure, ArticleResponseEntity>> getArticles({int page = 1});
}