import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/login.dart';
import '../pages/splash_screen.dart';
import 'authentication__service.dart';
import '../pages/page_controller.dart' as t;

class AuthenticationStream extends StatefulWidget {
  //this is the first Stateful Widget of the app
  const AuthenticationStream({Key? key}) : super(key: key);

  @override
  State<AuthenticationStream> createState() => _AuthenticationStreamState();
}

class _AuthenticationStreamState extends State<AuthenticationStream> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationService>(
      //we immediatly use the provider instantiate above
      builder: (ctx, AuthenticationService auth, _) {
        print(auth.status);
        switch (auth.status) {
          //depending on the status of the app, the switch case returns the appropriate screen
          case Status.uninitialized:
            return const SplashScreen(); // a white screen with the logo of the app centered. Used as a loading screen.
          case Status.unauthenticated:
          case Status.authenticating:
            return const Login(); //if the authentication token has expired, the AuthenticateUserScreen is shown
          case Status.authenticated:
            return t.PageController();
        }
      },
    );
  }
}
