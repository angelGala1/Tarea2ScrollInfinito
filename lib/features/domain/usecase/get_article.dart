import 'package:dartz/dartz.dart';

import '../../../core/failure/failure.dart';
import '../entitie/article_response_entity.dart';
import '../repositorie/article_repository.dart';

class GetArticlesUseCase {
  final ArticleRepository repository;

  const GetArticlesUseCase(this.repository);
  Future<Either<Failure, ArticleResponseEntity>> call({int page = 1}) async {
    return await repository.getArticles(page: page);
  }
}