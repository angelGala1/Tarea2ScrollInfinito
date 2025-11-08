import 'package:equatable/equatable.dart';

abstract class TesteoEvent extends Equatable {
  const TesteoEvent();

  @override
  List<Object?> get props => [];
}

class TesteoIniciado extends TesteoEvent {}
