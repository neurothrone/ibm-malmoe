import 'package:flutter/material.dart';

import 'popup_menu_action.dart';

class CustomPopupMenu extends StatelessWidget {
  const CustomPopupMenu({
    Key? key,
    required this.onActionSelected,
  }) : super(key: key);

  final Function(PopupMenuAction) onActionSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopupMenuAction>(
      onSelected: (PopupMenuAction newSelection) {
        onActionSelected(newSelection);
      },
      icon: const Icon(Icons.more_horiz),
      tooltip: "More",
      itemBuilder: (context) => [
        const PopupMenuItem(
          padding: EdgeInsets.all(0.0),
          value: PopupMenuAction.profile,
          child: ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("My Profile"),
          ),
        ),
        const PopupMenuItem(
          padding: EdgeInsets.all(0.0),
          value: PopupMenuAction.settings,
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          padding: EdgeInsets.all(0.0),
          value: PopupMenuAction.logout,
          child: ListTile(
            leading: Icon(Icons.logout_rounded),
            title: Text("Log out"),
          ),
        ),
      ],
    );
  }
}
