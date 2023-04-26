import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'auth/auth_service.dart';
import 'auth/auth_screen.dart';
import 'events/events_screen.dart';
import 'firebase_options.dart';
import 'home/home_screen.dart';
import 'kaffson/kaffson_screen.dart';
import 'navigation/destination.dart';
import 'settings/settings_screen.dart';
import 'todays_lunch/todays_lunch_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (_) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "IBM Malmoe",
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            // TODO: Change universal color theme
            foregroundColor: Colors.white,
            backgroundColor: Colors.deepPurple,
            // primarySwatch: Colors.deepPurple,
          ),
        ),
        home: StreamBuilder<User?>(
          stream: AuthService.shared.authStateChanges(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const AuthScreen();
            } else {
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    context.watch<AppState>().currentDestination.title,
                  ),
                  leading: IconButton(
                    onPressed: context.watch<AppState>().currentDestination ==
                            Destination.home
                        ? null
                        : () => context
                            .read<AppState>()
                            .navigateTo(Destination.home),
                    icon: const Icon(Icons.home_rounded),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () => AuthService.shared.signOut(),
                      icon: const Icon(Icons.logout_rounded),
                    ),
                    IconButton(
                      onPressed: () => context
                          .read<AppState>()
                          .navigateTo(Destination.settings),
                      icon: const Icon(Icons.settings),
                    ),
                  ],
                ),
                body: context.watch<AppState>().currentDestination.body,
              );
            }
          },
        ),
      ),
    );
  }
}

extension ScaffoldBody on Destination {
  Widget get body {
    switch (this) {
      case Destination.home:
        return const HomeScreen();
      case Destination.settings:
        return const SettingsScreen();
      case Destination.kaffson:
        return const KaffsonScreen();
      case Destination.todaysLunch:
        return const TodaysLunchScreen();
      case Destination.events:
        return const EventsScreen();
    }
  }
}
