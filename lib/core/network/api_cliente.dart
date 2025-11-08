import 'package:dio/dio.dart';

import 'api_endpoints.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio) {
    _dio.options.baseUrl = ApiEndpoints.baseUrl;

    // 🔥 SOLO AGREGA ESTAS 3 LÍNEAS:
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 5);
    _dio.options.persistentConnection = true; // ← CLAVE!

    _dio.interceptors.add(
      LogInterceptor(
        responseBody: false, // ← Cambia a false para que no imprima tanto
        requestBody: false,
        error: true,
      ),
    );
  }

  Future<Response> get(
      String path, {
        Map<String, dynamic>? queryParameters,
      }) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }
}