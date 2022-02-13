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

Future<List<ChoreLog>> getChoreLogs(DateTime date, String kidName) async {
  var choreLogCollection = await getCollection('chore-log');
  var choreLogs = await choreLogCollection
      .find({'kidName': kidName, "calendarDay": date}).toList();
  List<ChoreLog> clList = [];
  for (var cl in choreLogs) {
    var choreLog = ChoreLog(
      calendarDay: cl["calendarDay"],
      kidName: cl["kidName"],
      chore: cl['chore'],
      isDone: cl['isDone'],
      isAlternating: cl['isAlternating'],
    );

    log(choreLog.toString());
    clList.add(choreLog);
  }
  return clList;
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
  log(choreMap.toString());
  return ChoreDay.fromMap(choreMap!);
}

// void main() async {
//   var chores = getChores("Eliyahu", DateTime.now());
//   log(chores.toString());
// }
