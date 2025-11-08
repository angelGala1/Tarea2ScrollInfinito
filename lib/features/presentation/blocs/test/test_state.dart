import 'package:equatable/equatable.dart';

class TesteoState extends Equatable {
  final String mensaje;

  const TesteoState({required this.mensaje});

  TesteoState copyWith({String? mensaje}) {
    return TesteoState(mensaje: mensaje ?? this.mensaje);
  }

  @override
  List<Object?> get props => [mensaje];
}
