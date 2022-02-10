import 'dart:developer';

import 'package:chores/components/kids/kid_card.dart';
import 'package:chores/secrets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'database/models/kid.dart';

Future<List<Kid>> getKidsMongo() async {
  Db db = await Db.create(dbString);
  await db.open();
  log("Connected to database");
  DbCollection kidsCollection = DbCollection(db, 'kids');
  var kids = await kidsCollection.find().toList();
  List<Kid> kidList = [];
  for (var kid in kids) {
    var k = Kid(
        id: kid["_id"],
        name: kid["name"],
        dailyPoints: kid['dailyPoints'],
        alternatingPoints: kid['alternatingPoints']);
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
          return SizedBox(
            height: 1,
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 40.0, 0, 20.0),
                  child: SpinKitPianoWave(
                    color: Colors.deepPurple,
                    size: 200.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Fetching your kids! (From MongoDB)",
                    style: TextStyle(fontFamily: "RobotoSlab"),
                  ),
                ),
              ],
            ),
          );
        }
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
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
