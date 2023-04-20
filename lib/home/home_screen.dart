import 'package:flutter/material.dart';

import '../daily_lunch/daily_lunch_screen.dart';
import '../kaffson/kaffson_screen.dart';
import 'card_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "IBM Malmoe",
        ),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(10.0),
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: [
          CardButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DailyLunchScreen(),
              ),
            ),
            text: "Ica Maxi Daily Lunch",
            icon: Icons.food_bank,
          ),
          CardButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const KaffsonScreen(),
              ),
            ),
            text: "Kaffson",
            icon: Icons.coffee_maker,
          ),
          const CardButton(
            onPressed: null,
            // onPressed: () => Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const EventsScreen(),
            //   ),
            // ),
            text: "Events",
            icon: Icons.event,
          ),
        ],
      ),
    );
  }
}
