import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grin_plus_plus/crypto/ed25519hd.dart';
import 'package:grin_plus_plus/native/tor/tor_plugin.dart';
import 'package:grin_plus_plus/repositories/session_repository.dart';
import 'package:grin_plus_plus/screens/root_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/screens.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  @override
  RootState get initialState => RootState.initial();

  @override
  Stream<RootState> mapEventToState(RootEvent event) async* {
    if (event is InitApp) {
      SessionRepository.sessionStream.listen((session) {
        _generateTorPrivateKey(session.sessionToken);
      });
    }
    if (event is StartTor) {
      TorPlugin tor = TorPlugin();
      String onionAddress = await tor.startTorService(
        int.parse(DotEnv().env['TOR_CONTROL_PORT']),
        int.parse(DotEnv().env['TOR_SOCKS_PORT']),
        DotEnv().env['TOR_CONTROL_PASSWORD'],
        DotEnv().env['TOR_HASHED_PASSWORD'],
      );
      Stream torStream = TorPlugin.torServerDataStream.receiveBroadcastStream();
      torStream.listen((event) {
        var a = 1;
      });
      if (onionAddress != null && onionAddress.isNotEmpty) {
        yield state.copyWith(
          torServiceRunning: true,
          onionHostname: onionAddress,
          torListenerDataStream: torStream,
        );
      }
    }
    if (event is StopTor) {
      TorPlugin tor = TorPlugin();
      await tor.stopTorService();
      yield state.copyWith(torServiceRunning: false);
    }
    if (event is ChangeScreen) {
      Map<Screen, Object> screenData;
      if (event.additionalData != null) {
        screenData = Map.from(state.screenData);
        screenData[event.screen] = event.additionalData;
      }
      yield state.copyWith(
        currentScreen: event.screen,
        screenData: screenData,
      );
    }
    if (event is AppPaused) {

    }
  }

  void _generateTorPrivateKey(String seed) {
    KeyData master = ED25519_HD_KEY.getMasterKeyFromSeed(seed);
  }
}