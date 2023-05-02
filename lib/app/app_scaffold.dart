import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../features/profile/profile_screen.dart';
import '../features/home/home_screen.dart';
import '../features/kaffson/kaffson_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/todays_lunch/todays_lunch_screen.dart';
import 'app_state.dart';
import 'components/destination.dart';
import 'components/custom_popup_menu.dart';
import 'components/popup_menu_action.dart';
import 'components/sign_out_dialog.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    _onActionSelected(selectedAction, appState, context),
              ),
            ],
          ),
          body: appState.currentDestination.body,
        );
      },
    );
  }

  Future<void> _onActionSelected(
    PopupMenuAction selectedAction,
    AppState appState,
    BuildContext context,
  ) async {
    switch (selectedAction) {
      case PopupMenuAction.profile:
        appState.navigateTo(Destination.profile);
        break;
      case PopupMenuAction.settings:
        appState.navigateTo(Destination.settings);
        break;
      case PopupMenuAction.logout:
        final shouldSignOut = await showSignOutDialog(context);
        if (shouldSignOut) appState.logOut();
        break;
    }
  }

  Future<bool> showSignOutDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return const SignOutDialog();
      },
    ).then((shouldSignOut) => shouldSignOut ?? false);
  }
}

extension ScaffoldBody on Destination {
  Widget get body {
    switch (this) {
      case Destination.home:
        return const HomeScreen();
      case Destination.profile:
        return const ProfileScreen();
      case Destination.settings:
        return const SettingsScreen();
      case Destination.kaffson:
        return const KaffsonScreen();
      case Destination.todaysLunch:
        return const TodaysLunchScreen();
    }
  }
}
