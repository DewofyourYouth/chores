import 'dart:developer';

import 'package:chores/kid_button.dart';
import 'package:chores/secrets.dart';
import 'package:flutter/cupertino.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Kid {
  ObjectId id;
  String name;

  Kid({required this.id, required this.name});
}

Future<List<Kid>> getKidsMongo() async {
  Db db = await Db.create(dbString);
  await db.open();
  log("Connected to database");
  DbCollection kidsCollection = DbCollection(db, 'kids');
  var kids = await kidsCollection.find().toList();
  List<Kid> kidList = [];
  for (var kid in kids) {
    var k = Kid(id: kid["_id"], name: kid["name"]);
    kidList.add(k);
  }
  return kidList;
}

FutureBuilder getMongoKidsWidgets() {
  var kids = getKidsMongo();
  return FutureBuilder(
      future: kids,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        if (snapshot.hasData) {
          return Wrap(
            children: [...snapshot.data.map((k) => KidButton(name: k.name))],
          );
        } else {
          return Text("Howdy");
        }
      });
}
