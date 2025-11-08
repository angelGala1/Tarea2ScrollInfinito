import 'failure.dart';

class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.code,
    super.data,
  });

  factory NetworkFailure.noInternet() => const NetworkFailure(
    message: 'No hay conexión a internet. Verifica tu conexión e intenta nuevamente.',
    code: 'NO_INTERNET',
  );

  factory NetworkFailure.timeout() => const NetworkFailure(
    message: 'Tiempo de espera agotado. Por favor, intenta nuevamente.',
    code: 'TIMEOUT',
  );

  factory NetworkFailure.serverError([int? statusCode]) => NetworkFailure(
    message: 'Error del servidor. Intenta más tarde.',
    code: 'SERVER_ERROR',
    data: statusCode,
  );

  factory NetworkFailure.badRequest() => const NetworkFailure(
    message: 'Solicitud incorrecta. Verifica los datos enviados.',
    code: 'BAD_REQUEST',
  );

  factory NetworkFailure.unauthorized() => const NetworkFailure(
    message: 'No autorizado. Inicia sesión nuevamente.',
    code: 'UNAUTHORIZED',
  );

  factory NetworkFailure.notFound() => const NetworkFailure(
    message: 'Recurso no encontrado.',
    code: 'NOT_FOUND',
  );

  factory NetworkFailure.unknown(String message) => NetworkFailure(
    message: message.isNotEmpty ? message : 'Error desconocido',
    code: 'UNKNOWN',
  );
}