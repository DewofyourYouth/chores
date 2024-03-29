import 'dart:developer';
import 'package:flutter/material.dart';

import 'pages/settings_page.dart';
import 'utils/dates.dart';

import 'components/kids/get_kids_from_datebase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chores App',
      theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: "OpenSans",
          textTheme: const TextTheme(
            headline4: TextStyle(
              fontFamily: 'RobotoSlab',
              color: Colors.tealAccent,
            ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.teal,
          )),
      home: const MyHomePage(title: 'Kid\'s Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> kids = [];
  DateTime date = DateTime.now();
  FutureBuilder kidsFuture = getMongoKidsWidgets(DateTime.now());

  void resetDate() {
    setState(() {
      date = DateTime.now();
      log(date.toString());
      kidsFuture = getMongoKidsWidgets(date);
    });
  }

  void decrementDate() {
    setState(() {
      date = date.addDays(-1);
      log(date.toString());
      kidsFuture = getMongoKidsWidgets(date);
    });
  }

  void incrementDate() {
    setState(() {
      date = date.addDays(1);
      log(date.toString());
      kidsFuture = getMongoKidsWidgets(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: kidsFuture,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.tealAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: decrementDate,
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              tooltip: "Previous Day",
            ),
            IconButton(
              onPressed: resetDate,
              icon: const Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              tooltip: "Rest to current date",
            ),
            IconButton(
              onPressed: incrementDate,
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.black,
              ),
              tooltip: "Next Day",
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ),
                );
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
              tooltip: "Next Day",
            )
          ],
        ),
      ),
    );
  }
}
