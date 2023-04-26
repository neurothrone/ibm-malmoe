import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

const icaMaxiWeeklyMenuUrl =
    "https://www.ica.se/butiker/maxi/malmo/maxi-ica-stormarknad-vastra-hamnen-11981/butiken/veckans-matsedel/";

class DailyLunchScreen extends StatelessWidget {
  const DailyLunchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today's Lunch"),
      ),
      body: const WeeklyMenu(),
    );
  }
}

class WeeklyMenu extends StatefulWidget {
  const WeeklyMenu({super.key});

  @override
  State<WeeklyMenu> createState() => _WeeklyMenuState();
}

class _WeeklyMenuState extends State<WeeklyMenu> {
  String week = "";
  List<String> menu = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Make an HTTP request
    final response = await http.get(Uri.parse(icaMaxiWeeklyMenuUrl));

    // Parse the HTML content
    dom.Document document = parser.parse(response.body);

    // Get the <div> element with the "content" class that has the data we are
    // interested in
    List<String> pElementsTextContent = [];
    final divElement = document.querySelector('.content');

    if (divElement != null) {
      // Get the first <div> child element
      final childDivElement = divElement.children.first;

      // Find all the <p> elements inside the child <div>
      final pElements = childDivElement.querySelectorAll('p');

      // Get all <p> elements where the text content is not empty
      for (int i = 0; i < pElements.length; i++) {
        String textContent = pElements[i].text.trim();
        if (textContent.isNotEmpty) {
          pElementsTextContent.add(textContent);
        }
      }
    }

    // If empty then either there is no menu for this week or the html has changed
    if (pElementsTextContent.isEmpty) {
      setState(() {
        week = "No menu this week.";
      });
      return;
    }

    // The first non-empty <p> element text context is the week and the rest are
    // the days from monday to friday
    final currentWeek = pElementsTextContent.first;
    final dailyMenu = pElementsTextContent.sublist(1);

    setState(() {
      week = currentWeek;
      menu = dailyMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10.0),
        Text(
          week,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        // We use .separated() instead of .build() so no separator is shown
        // after the last element
        ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(10.0),
          itemCount: menu.length,
          itemBuilder: (BuildContext context, int index) {
            final item = menu[index];

            // Even indexed elements have the day name and odd have the
            // lunch of that day
            if (index.isEven) {
              return Text(
                item,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              );
            } else {
              return Text(
                item,
                style: const TextStyle(
                  fontSize: 18,
                ),
              );
            }
          },
          // If it is an odd index then its a daily lunch and we want to add
          // a separator before we show the next day name
          separatorBuilder: (BuildContext context, int index) => index.isOdd
              ? const Divider(color: Colors.grey)
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
