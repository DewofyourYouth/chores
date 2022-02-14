import 'package:flutter/material.dart';

import '../../database/queries.dart';
import '../../utils/dates.dart';
import '../ui/spinner.dart';
import 'kid_card.dart';

FutureBuilder getMongoKidsWidgets(DateTime? date) {
  date ??= DateTime.now();
  var dateStr = weekdayMonthDayYear.format(date);
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
          return ListView(
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  dateStr,
                  style:
                      const TextStyle(fontFamily: "RobotoSlab", fontSize: 30.0),
                ),
              )),
              ...snapshot.data.map((k) => KidCard(kid: k, date: date!))
            ],
          );
        } else {
          return const Text("Howdy");
        }
      });
}
