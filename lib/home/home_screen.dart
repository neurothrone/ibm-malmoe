import 'package:flutter/material.dart';

import '../daily_lunch/daily_lunch_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IBM Malmoe"),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(10.0),
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.purple[100],
            child: TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DailyLunchScreen(),
                ),
              ),
              child: const Text("Ica Maxi Daily Lunch"),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.purple[200],
            child: const Text("Kaffson"),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.purple[300],
            child: const Text("Events"),
          ),
        ],
      ),
    );
  }
}
