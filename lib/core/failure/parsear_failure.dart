import 'failure.dart';

class ParseFailure extends Failure {
  const ParseFailure({
    required super.message,
    super.code,
    super.data,
  });

  factory ParseFailure.invalidData() => const ParseFailure(
        message: 'Los datos recibidos no son válidos.',
        code: 'INVALID_DATA',
      );

  factory ParseFailure.invalidJson() => const ParseFailure(
        message: 'Error al procesar la respuesta del servidor.',
        code: 'INVALID_JSON',
      );

  factory ParseFailure.missingField(String field) => ParseFailure(
        message: 'Falta el campo requerido: $field',
        code: 'MISSING_FIELD',
        data: field,
      );
}