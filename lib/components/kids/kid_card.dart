import 'package:flutter/material.dart';

import 'package:chores/pages/chores_page.dart';
import '../../database/models/kid.dart';

class Data {
  String name;

  Data({required this.name});
}

class KidCard extends StatelessWidget {
  KidCard({
    required this.kid,
  }) : super(key: ObjectKey(kid));
  final Kid kid;

  @override
  Widget build(BuildContext context) {
    var white = Colors.white;
    var data = Data(name: kid.name);
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.child_care),
            title: Text(
              kid.name,
              style: const TextStyle(fontFamily: "RobotoSlab"),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Alternating Points: ${kid.alternatingPoints}, Daily Points: ${kid.dailyPoints}, Total: ${kid.alternatingPoints + kid.dailyPoints}"),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => KidsChoresPage(data: data)));
            },
            label: Text("Go to ${kid.name} page"),
            icon: Icon(Icons.navigate_next, color: white, size: 30.0),
          )
        ],
      ),
    );
  }
}
