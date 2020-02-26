import 'package:equatable/equatable.dart';
import 'package:grin_plus_plus/screens/screens.dart';

abstract class RootEvent extends Equatable {
  const RootEvent();

  @override
  List<Object> get props => [];
}

class AppPaused extends RootEvent {}
class ChangeScreen<T> extends RootEvent {
  final Screen screen;
  final T additionalData;

  ChangeScreen(this.screen, {this.additionalData});

  @override
  List<Object> get props => [screen, additionalData];
}