extension StringFormating on String {
  String format(List<String> values) {
    int index = 0;
    return replaceAllMapped(RegExp(r'{.*?}'), (_) {
      final value = values[index];
      index++;
      return value;
    });
  }

  String formatWithMap(Map<String, String> mappedValues) {
    return replaceAllMapped(RegExp(r'{(.*?)}'), (match) {
      final mapped = mappedValues[match[1]];
      if (mapped == null) {
        throw ArgumentError(
            '$mappedValues does not contain the key "${match[1]}"');
      }
      return mapped;
    });
  }
}
