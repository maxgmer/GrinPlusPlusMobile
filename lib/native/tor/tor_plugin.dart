import 'dart:core';

import 'package:flutter/services.dart';
import 'package:grin_plus_plus/native/tor/tor_plugin_strings.dart' as torNames;

class TorPlugin {
  static TorPlugin _torPlugin;
  static const torMethodChannel = const MethodChannel(torNames.torMethodChannelName);
  static const torServerDataStream = const EventChannel(torNames.torServerEventChannelName);

  TorPlugin._internal();

  factory TorPlugin() {
    if (_torPlugin == null) {
      _torPlugin = TorPlugin._internal();
    }
    return _torPlugin;
  }

  Future<String> startTorService(int controlPort, int socksPort,
      String controlPassword, String hashedControlPassword) async {
    try {
      String onionAddress = await torMethodChannel.invokeMethod(
        torNames.methodStartTorService,
        <String, dynamic> {
          torNames.startTorServiceArg1: controlPort,
          torNames.startTorServiceArg2: socksPort,
          torNames.startTorServiceArg3: controlPassword,
          torNames.startTorServiceArg4: hashedControlPassword,
        },
      );
      return onionAddress;
    } on PlatformException catch (error) {
      print('Exception occured: ' + error.message);
      return null;
    }
  }

  Future stopTorService() async {
    await torMethodChannel.invokeMethod(torNames.methodStopTorService);
  }
}

