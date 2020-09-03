import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

class SessionRepository {
  static BehaviorSubject<Session> _sessionTokenController = BehaviorSubject<Session>();

  static Stream<Session> get sessionStream => _sessionTokenController.stream;
  static Session get currentSession => _sessionTokenController.value;

  static void addSessionToken(Session sessionToken) {
    if (sessionToken != null) {
      _sessionTokenController.add(sessionToken);
    }
  }

  static void dispose() {
    _sessionTokenController.close();
  }
}

class Session extends Equatable {
  final String sessionToken;
  final String torAddress;
  final int listenerPort;

  Session({
    this.sessionToken,
    this.torAddress,
    this.listenerPort,
  });

  @override
  List<Object> get props => [
    sessionToken,
    torAddress,
    listenerPort,
  ];
}