import 'package:dio/dio.dart';

import '../../../core/failure/failure.dart';
import '../../../core/failure/network_failure.dart';
import '../../../core/network/api_cliente.dart';
import '../../../core/network/api_endpoints.dart';
import '../model/banner_model.dart';
import '../model/response/article_response_model.dart';

abstract class ArticleRemoteDataSource {
  Future<ArticleResponseModel> getArticles({int page = 1});
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final ApiClient apiClient;

  ArticleRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<ArticleResponseModel> getArticles({int page = 1}) async {
    try {
      final response = await apiClient.get(
        ApiEndpoints.articles,
        queryParameters: {'page': page},
      );

      if (response.statusCode == 200 && response.data != null) {
        return ArticleResponseModel.fromJson(response.data);
      } else {
        throw NetworkFailure.serverError(response.statusCode);
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      if (e is Failure) rethrow;
      throw NetworkFailure.unknown(e.toString());
    }
  }
  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure.timeout();

      case DioExceptionType.connectionError:
        return NetworkFailure.noInternet();

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        switch (statusCode) {
          case 400:
            return NetworkFailure.badRequest();
          case 401:
            return NetworkFailure.unauthorized();
          case 404:
            return NetworkFailure.notFound();
          case 500:
          case 502:
          case 503:
            return NetworkFailure.serverError(statusCode);
          default:
            return NetworkFailure.serverError(statusCode);
        }

      case DioExceptionType.cancel:
        return const NetworkFailure(
          message: 'Solicitud cancelada',
          code: 'CANCELLED',
        );

      default:
        return NetworkFailure.unknown(error.message ?? 'Error desconocido');
    }
  }
}

/*
abstract class ArticleRemoteDataSource {
  Future<ArticleResponseModel> getArticles({int page = 1});
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final ApiClient apiClient;

  ArticleRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<ArticleResponseModel> getArticles({int page = 1}) async {
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    print('🔵 [DataSource] Iniciando request - Página $page');
    final startTotal = DateTime.now();

    try {
      // Hacer el request
      final beforeRequest = DateTime.now();
      print('🌐 [DataSource] Llamando a ${ApiEndpoints.articles}?page=$page');

      final response = await apiClient.get(
        ApiEndpoints.articles,
        queryParameters: {'page': page},
      );

      final requestTime = DateTime.now().difference(beforeRequest).inMilliseconds;
      print('⏱️  [DataSource] Request HTTP completado: ${requestTime}ms');
      print('📊 [DataSource] Status code: ${response.statusCode}');

      if (response.statusCode == 200 && response.data != null) {
        // Parsear JSON
        final beforeParsing = DateTime.now();
        print('🔄 [DataSource] Parseando JSON...');

        final model = ArticleResponseModel.fromJson(response.data);

        final parsingTime = DateTime.now().difference(beforeParsing).inMilliseconds;
        print('⏱️  [DataSource] Parsing completado: ${parsingTime}ms');
        print('✅ [DataSource] ${model.data.length} artículos parseados');

        final totalTime = DateTime.now().difference(startTotal).inMilliseconds;
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('📊 [DataSource] RESUMEN:');
        print('1. HTTP Request:  ${requestTime}ms');
        print('2. JSON Parsing:  ${parsingTime}ms');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('⏱️  [DataSource] TOTAL: ${totalTime}ms');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

        return model;
      } else {
        print('❌ [DataSource] Status code inválido: ${response.statusCode}');
        throw NetworkFailure.serverError(response.statusCode);
      }
    } on DioException catch (e) {
      print('❌ [DataSource] DioException: ${e.type} - ${e.message}');
      final totalTime = DateTime.now().difference(startTotal).inMilliseconds;
      print('⏱️  [DataSource] Tiempo hasta error: ${totalTime}ms');
      throw _handleDioError(e);
    } catch (e) {
      print('❌ [DataSource] Exception: $e');
      final totalTime = DateTime.now().difference(startTotal).inMilliseconds;
      print('⏱️  [DataSource] Tiempo hasta error: ${totalTime}ms');

      if (e is Failure) rethrow;
      throw NetworkFailure.unknown(e.toString());
    }
  }

  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        print('⚠️  [DataSource] Timeout detectado: ${error.type}');
        return NetworkFailure.timeout();

      case DioExceptionType.connectionError:
        print('⚠️  [DataSource] Error de conexión');
        return NetworkFailure.noInternet();

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        print('⚠️  [DataSource] Bad response: $statusCode');
        switch (statusCode) {
          case 400:
            return NetworkFailure.badRequest();
          case 401:
            return NetworkFailure.unauthorized();
          case 404:
            return NetworkFailure.notFound();
          case 500:
            return NetworkFailure.serverError(statusCode);
          default:
            return NetworkFailure.serverError(statusCode);
        }

      default:
        print('⚠️  [DataSource] Error desconocido: ${error.type}');
        return NetworkFailure.unknown(error.message ?? 'Error desconocido');
    }
  }
}*/