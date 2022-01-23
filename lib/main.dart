import 'package:flutter/material.dart';
import 'package:flutter_playground/auth_service.dart';
import 'package:flutter_playground/login_page.dart';
import 'package:flutter_playground/sign_up_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _authService.showLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery App',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      home: StreamBuilder<AuthState>(
          stream: _authService.authStateController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Navigator(
                pages: [
                  // Show Login Page
                  if (snapshot.data!.authFlowStatus == AuthFlowStatus.login)
                    MaterialPage(
                        child: LoginPage(
                            shoudShowSignUp: _authService.showSignUp)),

                  // Show Sign Up Page
                  if (snapshot.data!.authFlowStatus == AuthFlowStatus.signup)
                    MaterialPage(
                        child: SignUpPage(
                            shouldShowLogin: _authService.showLogin)),
                ],
                onPopPage: (route, result) => route.didPop(result),
              );
            } else {
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
