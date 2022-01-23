import 'dart:async';

enum AuthFlowStatus { login, signup, verification, session }

class AuthState {
  final AuthFlowStatus authFlowStatus;

  AuthState({required this.authFlowStatus});
}

class AuthService {
  final authStateController = StreamController<AuthState>();

  void showSignUp() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.signup);
    authStateController.add(state);
  }

  void showLogin() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.login);
    authStateController.add(state);
  }
}
