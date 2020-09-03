import 'package:equatable/equatable.dart';
import 'package:grin_plus_plus/screens/screens.dart';

class RootState extends Equatable {
  final Map<Screen, Object> screenData;
  final Screen currentScreen;
  final String onionHostname;
  final Stream torListenerDataStream;
  final bool torServiceRunning;

  RootState({
    this.currentScreen,
    this.screenData,
    this.onionHostname,
    this.torListenerDataStream,
    this.torServiceRunning,
  });

  factory RootState.initial() {
    return RootState(
      currentScreen: Screen.walletChoiceScreen,
      screenData: {},
    );
  }

  String get torPublicKey => onionHostname?.replaceFirst('.onion', '');
  String get httpAddress {
    if (torPublicKey != null) {
      return 'https://$torPublicKey.grinplusplus.com';
    }
    return null;
  }

  RootState copyWith({Screen currentScreen, Map<Screen, Object> screenData,
    String onionHostname, Stream<dynamic> torListenerDataStream,
    bool torServiceRunning}) {
    return RootState(
      currentScreen: currentScreen ?? this.currentScreen,
      screenData: screenData ?? this.screenData,
      onionHostname: onionHostname ?? this.onionHostname,
      torListenerDataStream: torListenerDataStream ?? this.torListenerDataStream,
      torServiceRunning: torServiceRunning ?? this.torServiceRunning,
    );
  }

  @override
  List<Object> get props => [
    currentScreen,
    screenData,
    onionHostname,
    torListenerDataStream,
    torServiceRunning,
  ];
}