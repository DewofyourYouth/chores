import 'package:flutter/material.dart';

import 'package:chores/pages/chores_page.dart';
import '../../database/models/kid.dart';

class Data {
  String name;
  DateTime date;

  Data({required this.name, required this.date});
}

class KidCard extends StatelessWidget {
  KidCard({
    required this.kid,
    required this.date,
  }) : super(key: ObjectKey(kid));
  final KidPoints kid;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    var data = Data(name: kid.kid.name, date: date);
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(
              Icons.child_care,
              color: Colors.tealAccent,
            ),
            title: Text(
              kid.kid.name,
              style: Theme.of(context).textTheme.headline4,
            ),
            isThreeLine: true,
            subtitle: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
              child: Text("The daily chores for ${kid.kid.name}.\n"
                  "Current score: ${kid.points} pts"),
            ),
          ),
          NavigateToChoresPage(kid: kid.kid, data: data)
        ],
      ),
    );
  }
}

class NavigateToChoresPage extends StatelessWidget {
  const NavigateToChoresPage({
    Key? key,
    required this.kid,
    required this.data,
  }) : super(key: key);

  final Kid kid;
  final Data data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        child: FloatingActionButton.extended(
          heroTag: kid.name,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => KidsChoresPage(data: data)));
          },
          label: const Text("Chores"),
          icon: const Icon(
            Icons.room_service_outlined,
            size: 30.0,
          ),
        ),
      ),
    );
  }
}
