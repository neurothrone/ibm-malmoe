import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'auth/auth_service.dart';
import 'auth/auth_screen.dart';
import 'constants.dart';
import 'events/events_screen.dart';
import 'firebase_options.dart';
import 'home/custom_popup_menu.dart';
import 'home/home_screen.dart';
import 'home/popup_menu_action.dart';
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

// TODO: extract out app bar into a widget to reduce code here
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (_) => AppState(),
      child: Consumer<AppState>(
        builder: (context, AppState appState, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "IBM Malmoe",
            theme: getAppTheme(context, context.watch<AppState>().isDarkMode),
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
                        onPressed:
                            context.watch<AppState>().currentDestination ==
                                    Destination.home
                                ? null
                                : () => context
                                    .read<AppState>()
                                    .navigateTo(Destination.home),
                        icon: const Icon(Icons.home_rounded),
                      ),
                      actions: [
                        CustomPopupMenu(
                          onActionSelected: (PopupMenuAction selectedAction) {
                            switch (selectedAction) {
                              case PopupMenuAction.profile:
                                break;
                              case PopupMenuAction.logout:
                                AuthService.shared.signOut();
                                break;
                              case PopupMenuAction.settings:
                                context
                                    .read<AppState>()
                                    .navigateTo(Destination.settings);
                                break;
                              case PopupMenuAction.toggleDarkMode:
                                context.read<AppState>().toggleAppTheme();
                                break;
                            }
                          },
                        ),

                        // IconButton(
                        //   onPressed: () =>
                        //       context.read<AppState>().toggleAppTheme(),
                        //   icon: Icon(
                        //     context.watch<AppState>().isDarkMode
                        //         ? Icons.dark_mode
                        //         : Icons.sunny,
                        //   ),
                        // ),
                        // IconButton(
                        //   onPressed: () => AuthService.shared.signOut(),
                        //   icon: const Icon(Icons.logout_rounded),
                        // ),
                        // IconButton(
                        //   onPressed: () => context
                        //       .read<AppState>()
                        //       .navigateTo(Destination.settings),
                        //   icon: const Icon(Icons.settings),
                        // ),
                        // IconButton(
                        //   onPressed: () => context
                        //       .read<AppState>()
                        //       .navigateTo(Destination.settings),
                        //   icon: const Icon(Icons.account_circle),
                        // ),
                      ],
                    ),
                    body: context.watch<AppState>().currentDestination.body,
                  );
                }
              },
            ),
          );
        },
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
