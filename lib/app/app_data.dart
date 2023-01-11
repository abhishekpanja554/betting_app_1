import 'package:firebase_auth/firebase_auth.dart';

class SessionManager {
  
  static final SessionManager _session = SessionManager._internal();

  User? userInfo;

  factory SessionManager() {
    return _session;
  }

  SessionManager._internal();
}