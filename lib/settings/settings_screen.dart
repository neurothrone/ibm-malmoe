import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../app_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 10.0),
            const Text("Dark Mode"),
            const Spacer(),
            Switch(
              value: context.watch<AppState>().isDarkMode,
              onChanged: (_) => context.read<AppState>().toggleAppTheme(),
            ),
            const SizedBox(width: 10.0),
          ],
        ),
      ],
    );
  }
}
