import 'package:chores/chores_page.dart';
import 'package:flutter/material.dart';

class Data {
  String name;

  Data({required this.name});
}

class KidButton extends StatelessWidget {
  KidButton({
    required this.name,
  }) : super(key: ObjectKey(name));
  final String name;

  @override
  Widget build(BuildContext context) {
    var white = Colors.white;
    var data = Data(name: name);
    return ElevatedButton.icon(
      icon: Icon(
        Icons.child_care,
        color: white,
        size: 24.0,
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => KidsChoresPage(data: data)));
      },
      label: Text(name),
    );
  }
}
