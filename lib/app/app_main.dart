import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'app_scaffold.dart';
import 'app_state.dart';
import '../features/auth/auth_service.dart';
import '../features/auth/auth_screen.dart';
import '../core/constants.dart';

class AppMain extends StatelessWidget {
  const AppMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: getAppTheme(context, context.watch<AppState>().isDarkMode),
      home: StreamBuilder<User?>(
        stream: AuthService.shared.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const AuthScreen();
          } else {
            return const AppScaffold();
          }
        },
      ),
    );
  }
}
