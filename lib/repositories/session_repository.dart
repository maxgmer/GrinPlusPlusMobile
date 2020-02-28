import 'dart:async';

import 'package:rxdart/rxdart.dart';

class SessionRepository {
  static BehaviorSubject<String> _sessionTokenStream = BehaviorSubject<String>();

  Stream<String> get sessionTokenStream => _sessionTokenStream.stream;

  static void addSessionToken(String sessionToken) {
    if (sessionToken != null && sessionToken.isNotEmpty) {
      _sessionTokenStream.add(sessionToken);
    }
  }

  static void dispose() {
    _sessionTokenStream.close();
  }
}