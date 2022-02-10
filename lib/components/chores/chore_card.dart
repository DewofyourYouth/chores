import 'package:flutter/material.dart';

class ChoreCard extends StatefulWidget {
  final String chore;
  const ChoreCard({
    Key? key,
    required this.chore,
  }) : super(key: key);

  @override
  State<ChoreCard> createState() => _ChoreCardState();
}

class _ChoreCardState extends State<ChoreCard> {
  bool done = false;

  void toggleDone() {
    setState(() {
      done = !done;
    });
  }

  IconButton getDoneIcon() => !done
      ? IconButton(
          icon: const Icon(Icons.radio_button_unchecked),
          onPressed: toggleDone,
        )
      : IconButton(
          icon: const Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          onPressed: toggleDone,
        );

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: getDoneIcon(),
          title: Text(
            widget.chore,
            style: const TextStyle(fontFamily: "RobotoSlab"),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: const Text("Done"),
              onPressed: () => setState(() {
                done = true;
              }),
            ),
            TextButton(
                onPressed: () => setState(() {
                      done = false;
                    }),
                child: const Text("Not Done"))
          ],
        )
      ],
    ));
  }
}
