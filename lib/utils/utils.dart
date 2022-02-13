String createChoreLogId(DateTime date, String kidName, String chore) {
  date = DateTime(date.year, date.month, date.day);
  var choreStripped = chore.split(' ').map((s) => s.trim()).join('');
  return "${date.toString()}:$kidName:$choreStripped";
}
