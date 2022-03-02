import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';

import 'models/chore_constants.dart';
import 'models/chore_day.dart';
import 'models/chores/alternating_chore.dart';
import 'models/chores/daily_chore.dart';
import '../secrets.dart';
import '../components/chores/utils.dart';

import 'models/kid.dart';

Future<DbCollection> getCollection(String collectionName) async {
  Db db = await Db.create(dbString);
  await db.open();
  log("connected to database!");
  return DbCollection(db, collectionName);
}

Future<List<KidPoints>> getKidsMongo(DateTime date) async {
  var kids = await getKidsWithChoreDays();
  List<KidPoints> kidList = [];
  for (var kid in kids) {
    var k = Kid(
      id: kid["id"],
      name: kid["name"],
    );

    initializeChores(kid['name'], date);
    kidList.add(KidPoints(kid: k, points: kid['points']));
  }
  return kidList;
}

Future<List<dynamic>> getKidsWithChoreDays() async {
  final kids = await getCollection("kids");
  final pipeline = AggregationPipelineBuilder()
      .addStage(Lookup(
          from: 'chores',
          localField: 'name',
          foreignField: 'kidName',
          as: 'choreDays'))
      .build();
  final result = await kids.aggregateToStream(pipeline).toList();
  var kidsList = result.toList().map((e) => (makeKidPointsList(e)));
  var kl = [];
  for (var k in kidsList) {
    var points = k['points']
        .map((v) => v.reduce((sum, el) => sum + el))
        .reduce((sum, el) => sum + el);
    k['points'] = points;
    var m = {
      "id": k["id"],
      "name": k['name'],
      'points': points,
    };
    kl.add(m);
  }
  return kl;
}

Map<String, dynamic> makeKidPointsList(Map<String, dynamic> e) {
  return {
    "id": e["_id"],
    "name": e['name'],
    "points": e['choreDays'].map((cd) => cd['chores'].map((c) =>
        c['isAlternating'] == true
            ? AlternatingChore.fromMap(c).getPoints()
            : DailyChore.fromMap(c).getPoints()))
  };
}

void updateChore(ChoreDay chore, DateTime date) async {
  String choreDayId = createChoreDayId(
    chore.kidName,
    date,
  );
  var choreDayCollection = await getCollection('chores');
  var cDay = await choreDayCollection.findOne({"_id": choreDayId});
  if (cDay != null) {
    await choreDayCollection.replaceOne({"_id": choreDayId}, chore.toMap());
  }
  await choreDayCollection.insertOne(chore.toMap());
}

Future<int> initializeChores(String kidName, DateTime date) async {
  var choreDay = await initializeChoreDay(kidName, date);
  var choreCollection = await getCollection('chores');
  choreCollection.insertOne(choreDay.toMap());
  return 1;
}

Future<Map<String, dynamic>?> getChores(String kidName, DateTime date) async {
  String choreId = createChoreDayId(kidName, date);
  var choreDayCollection = await getCollection('chores');
  return await choreDayCollection.findOne({"_id": choreId});
}

Future<ChoreDay> getChoreDay(String kidName, DateTime date) async {
  var choreDay = await getChores(kidName, date);
  if (choreDay == null) {
    await initializeChores(kidName, date);
    choreDay = await getChores(kidName, date);
  }
  return ChoreDay.fromMap(choreDay!);
}

Future<List<ChoreDay>> getAllChoreDays() async {
  var choreDayCollection = await getCollection('chores');
  var choresList =
      choreDayCollection.find().map((data) => ChoreDay.fromMap(data)).toList();
  return choresList;
}

void addDailyChores(
    String chore, String description, bool isAlternating) async {
  var dailyChoresCollection = await getCollection('daily-chores');
  dailyChoresCollection.insertOne({
    "_id": choreFormatter(chore),
    'chore': chore,
    "description": description,
    "isAlternating": isAlternating,
  });
}

Future<List<DailyChore>> getDailyChores() async {
  var dailyChoreCollection = await getCollection('daily-chores');
  var dailyChores = await dailyChoreCollection.find().toList();
  return dailyChores
      .where((chore) => chore['isAlternating'] != true)
      .map((chore) =>
          DailyChore(chore: chore['chore'], done: ChoreState.unmarked))
      .toList();
}
