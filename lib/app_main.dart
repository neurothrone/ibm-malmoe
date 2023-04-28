import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'auth/auth_service.dart';
import 'auth/auth_screen.dart';
import 'constants.dart';
import 'events/events_screen.dart';
import 'home/custom_popup_menu.dart';
import 'home/home_screen.dart';
import 'home/popup_menu_action.dart';
import 'kaffson/kaffson_screen.dart';
import 'navigation/destination.dart';
import 'settings/settings_screen.dart';
import 'todays_lunch/todays_lunch_screen.dart';

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
            return Consumer<AppState>(
              builder: (context, AppState appState, child) {
                return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(
                      appState.currentDestination.title,
                    ),
                    leading: IconButton(
                      onPressed: appState.currentDestination == Destination.home
                          ? null
                          : () => appState.navigateTo(Destination.home),
                      icon: const Icon(Icons.home_rounded),
                    ),
                    actions: [
                      CustomPopupMenu(
                        onActionSelected: (PopupMenuAction selectedAction) =>
                            _onActionSelected(selectedAction, appState),
                      ),
                    ],
                  ),
                  body: appState.currentDestination.body,
                );
              },
            );
          }
        },
      ),
    );
  }

  void _onActionSelected(PopupMenuAction selectedAction, AppState appState) {
    switch (selectedAction) {
      case PopupMenuAction.profile:
        // appState.navigateTo(Destination.profile);
        break;
      case PopupMenuAction.settings:
        appState.navigateTo(Destination.settings);
        break;
      case PopupMenuAction.logout:
        appState.logOut();
        break;
    }
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
