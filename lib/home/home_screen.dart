import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../app_state.dart';
import '../navigation/destination.dart';
import 'card_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(10.0),
      crossAxisCount: 2,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      children: [
        CardButton(
          onPressed: () =>
              context.read<AppState>().navigateTo(Destination.kaffson),
          text: "Kaffson",
          icon: Icons.coffee_maker,
        ),
        CardButton(
          onPressed: () =>
              context.read<AppState>().navigateTo(Destination.todaysLunch),
          text: "Today's Lunch",
          icon: Icons.food_bank,
        ),
        const CardButton(
          onPressed: null,
          // onPressed: () => context.read<AppState>().navigateTo(Destination.events),
          text: "Events",
          icon: Icons.event,
        ),
      ],
    );
  }
}
