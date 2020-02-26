import 'package:equatable/equatable.dart';
import 'package:grin_plus_plus/screens/screens.dart';

class RootState extends Equatable {
  final Map<Screen, Object> screenData;
  final Screen currentScreen;

  RootState({
    this.currentScreen,
    this.screenData,
  });

  factory RootState.initial() {
    return RootState(
      currentScreen: Screen.walletChoiceScreen,
      screenData: {}
    );
  }

  RootState copyWith({Screen currentScreen, Map<Screen, Object> screenData}) {
    return RootState(
      currentScreen: currentScreen ?? this.currentScreen,
      screenData: screenData ?? this.screenData,
    );
  }

  @override
  List<Object> get props => [currentScreen, screenData];
}