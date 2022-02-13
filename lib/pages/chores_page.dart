// import 'package:chores/database/models/chore_day.dart';
import 'package:chores/utils/dates.dart';
import 'package:flutter/material.dart';

import '../components/chores/chores_list.dart';
import '../components/kids/kid_card.dart';
import '../components/ui/spinner.dart';
import '../database/queries.dart';

//

class KidsChoresPage extends StatelessWidget {
  final Data data;
  const KidsChoresPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var kidName = data.name;
    var date = getDay();
    return Scaffold(
        appBar: AppBar(
          title: Text("$kidName Chores Page"),
        ),
        body: Center(
          child: kidsChoreBuilder(date, kidName),
        ));
  }
}

FutureBuilder kidsChoreBuilder(DateTime date, String kidName) {
  return FutureBuilder(
      future: getChores(kidName, date),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView(children: const [
            PianoSpinner(
              spinnerMsg: "Fetching your chores!",
            ),
          ]);
        }
        if (snapshot.hasError) {
          return Text(
            "Error: ${snapshot.error}",
          );
        }
        if (snapshot.hasData) {
          return ChoresList(
              now: DateTime.now(), chores: snapshot.data, name: kidName);
        } else {
          return const Text("Howdy");
        }
      });
}
