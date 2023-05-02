import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../app/app_state.dart';
import '../../app/components/destination.dart';
import 'components/primary_card_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, AppState appState, child) {
        return GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20.0),
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          children: [
            PrimaryCardButton(
              onPressed: () => appState.navigateTo(Destination.kaffson),
              text: "Kaffson",
              icon: Icons.coffee_maker,
            ),
            PrimaryCardButton(
              onPressed: () => appState.navigateTo(Destination.todaysLunch),
              text: "Today's Lunch",
              icon: Icons.food_bank,
            ),
          ],
        );
      },
    );
  }
}
