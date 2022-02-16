import 'package:chores/utils/dates.dart';
import 'package:flutter/material.dart';

import 'components/kids/get_kids_from_datebase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  final myController = TextEditingController();
  DateTime date = DateTime.now();
  FutureBuilder kidsFuture = getMongoKidsWidgets(DateTime.now());

  void decrementDate() {
    setState(() {
      date = date.addDays(-1);
      kidsFuture = getMongoKidsWidgets(date);
    });
  }

  void incrementDate() {
    setState(() {
      date = date.addDays(1);
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

      // We dont yet have the functionality to add a kid yet.
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _addKid,
      //   tooltip: 'Add Kid',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
