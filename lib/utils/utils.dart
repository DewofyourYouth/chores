List<dynamic> rotateList(List<dynamic> list, int rotations) {
  var rotatingList = list.map((element) => element).toList();
  for (int i = 0; i < rotations; i++) {
    var first = rotatingList.removeAt(0);
    rotatingList.add(first);
  }
  return rotatingList;
}
