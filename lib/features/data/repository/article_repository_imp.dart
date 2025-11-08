import 'package:dartz/dartz.dart';

import '../../../core/failure/failure.dart';
import '../../../core/failure/network_failure.dart';
import '../../../core/network/network_imf.dart';
import '../../domain/entitie/article_response_entity.dart';
import '../../domain/repositorie/article_repository.dart';
import '../datasource/article_data_source.dart';


class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ArticleRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ArticleResponseEntity>> getArticles({int page = 1}) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return Left(NetworkFailure.noInternet());
    }

    try {
      final result = await remoteDataSource.getArticles(page: page);
      return Right(result.toEntity());
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(NetworkFailure.unknown(e.toString()));
    }
  }
}