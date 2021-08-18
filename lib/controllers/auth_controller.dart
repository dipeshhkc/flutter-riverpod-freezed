import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:learningflutter/services/auth_service.dart';

final authControllerProvider = StateNotifierProvider<AuthController, User?>(
  (ref) => AuthController(ref.read)..appStarted(),
);

class AuthController extends StateNotifier<User?> {
  final Reader _read;

  StreamSubscription<User?>? _authStreamSubscription;

  AuthController(this._read) : super(null) {
    _authStreamSubscription?.cancel();
    _authStreamSubscription = _read(authServiceProvider)
        .authStateChanges
        .listen((user) => state = user);
  }

  void dispose() {
    _authStreamSubscription?.cancel();
    super.dispose();
  }

  void appStarted() {
    final user = _read(authServiceProvider).getCurrentUser();
    if (user == null) {
      _read(authServiceProvider).signInAnonymously();
    }
  }

  void signOut() {
    _read(authServiceProvider).signOut();
  }
}
