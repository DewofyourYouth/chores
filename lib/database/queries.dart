import 'dart:developer';

import 'package:chores/components/kids/kid_card.dart';
import 'package:chores/database/models/chore_log.dart';
import 'package:chores/secrets.dart';
import 'package:chores/components/chores/utils.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../components/ui/spinner.dart';
import 'models/kid.dart';

Future<DbCollection> getCollection(String collectionName) async {
  Db db = await Db.create(dbString);
  await db.open();
  log("connected to database!");
  return DbCollection(db, collectionName);
}

Future<List<Kid>> getKidsMongo() async {
  var kidsCollection = await getCollection('kids');
  // DbCollection kidsCollection = DbCollection(db, 'kids');
  var kids = await kidsCollection.find().toList();
  List<Kid> kidList = [];
  for (var kid in kids) {
    var k = Kid(
        id: kid["_id"],
        name: kid["name"],
        dailyPoints: kid['dailyPoints'],
        alternatingPoints: kid['alternatingPoints']);
    log(k.toString());
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

void insertChore(ChoreLog chore) async {
  String choreLogId =
      createChoreLogId(chore.calendarDay, chore.kidName, chore.chore);
  var choreLogCollection = await getCollection('chore-log');
  var cLog = await choreLogCollection.findOne({"_id": choreLogId});
  if (cLog != null) {
    await choreLogCollection.replaceOne({"_id": choreLogId}, chore.toMap());
  }
  log("Logging chore");
  await choreLogCollection.insertOne(chore.toMap());
  log("${chore.toString()} logged");
}
