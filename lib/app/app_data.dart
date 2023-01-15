import 'package:firebase_auth/firebase_auth.dart';

class SessionManager {
  static final SessionManager _session = SessionManager._internal();

  User? userInfo;

  //  bool getAuthStream() {
  //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if (user != null) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   });
  // }

  factory SessionManager() {
    return _session;
  }

  SessionManager._internal();
}
