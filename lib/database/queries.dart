import 'dart:developer';

import 'package:chores/database/models/chore_day.dart';
import 'package:chores/database/models/chore_log.dart';
import 'package:chores/secrets.dart';
import 'package:chores/components/chores/utils.dart';
import 'package:chores/utils/dates.dart';
import 'package:mongo_dart/mongo_dart.dart';

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
    initializeChores(kid['name'], getDay());
    log(k.toString());
    kidList.add(k);
  }
  return kidList;
}

void updateChore(ChoreDay chore) async {
  String choreDayId = createChoreDayId(
    chore.kidName,
    getDay(),
  );
  var choreDayCollection = await getCollection('chores');
  var cDay = await choreDayCollection.findOne({"_id": choreDayId});
  if (cDay != null) {
    await choreDayCollection.replaceOne({"_id": choreDayId}, chore.toMap());
  }
  log("Logging chore");
  await choreDayCollection.insertOne(chore.toMap());
  log("${chore.toString()} logged");
}

void initializeChores(String kidName, DateTime date) async {
  var choreDay = initializeChoreDay(kidName, date);
  var choreCollection = await getCollection('chores');
  choreCollection.insertOne(choreDay.toMap());
  log("logged ${choreDay.toString()}");
}

Future<ChoreDay> getChores(String kidName, DateTime date) async {
  String choreId = createChoreDayId(kidName, date);
  var choreDayCollection = await getCollection('chores');
  var choreMap = await choreDayCollection.findOne({"_id": choreId});
  return ChoreDay.fromMap(choreMap!);
}
