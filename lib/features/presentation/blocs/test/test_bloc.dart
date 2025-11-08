import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrolinfinitos/features/presentation/blocs/test/test_event.dart';
import 'package:scrolinfinitos/features/presentation/blocs/test/test_state.dart';


class TesteoBloc extends Bloc<TesteoEvent, TesteoState> {
  TesteoBloc() : super(const TesteoState(mensaje: "Inicializando BLoC de testeo...")) {
    on<TesteoIniciado>((event, emit) {
      emit(state.copyWith(mensaje: "BLoC de testeo activo ✅"));
    });
  }
}
