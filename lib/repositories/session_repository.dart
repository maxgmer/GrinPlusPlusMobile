import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

class SessionRepository {
  static BehaviorSubject<Session> _sessionTokenStream = BehaviorSubject<Session>();

  Stream<Session> get sessionTokenStream => _sessionTokenStream.stream;

  static void addSessionToken(Session sessionToken) {
    if (sessionToken != null) {
      _sessionTokenStream.add(sessionToken);
    }
  }

  static void dispose() {
    _sessionTokenStream.close();
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