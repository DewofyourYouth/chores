import 'package:chores/database/queries.dart';
import 'package:flutter/material.dart';

import 'components/kids/kid_card.dart';
import 'components/ui/spinner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Kid\'s Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> kids = [];
  final myController = TextEditingController();
  final FutureBuilder kidsFuture = getMongoKidsWidgets();

  void _addKid() {
    setState(() {
      kids.add(myController.text);
      // log(kids.toString());
      myController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          kidsFuture,
          // KidInput(myController: myController),
          // getKids(kids),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addKid,
        tooltip: 'Add Kid',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

FutureBuilder getMongoKidsWidgets() {
  var kids = getKidsMongo();
  return FutureBuilder(
      future: kids,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const PianoSpinner(
            spinnerMsg: "Fetching your kids! (From MongoDB)",
          );
        }
        if (snapshot.hasError) {
          return Text(
            "Error: ${snapshot.error}",
          );
        }
        if (snapshot.hasData) {
          return Wrap(
            children: [...snapshot.data.map((k) => KidCard(kid: k))],
          );
        } else {
          return const Text("Howdy");
        }
      });
}
