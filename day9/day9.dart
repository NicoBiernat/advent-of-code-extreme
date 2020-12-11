import 'dart:async';
import 'dart:io';
import 'dart:convert';

bool isCorrect(int number, List<int> previous) {
  if (previous.length != 25) {
    throw new FormatException();
  }
  for (int i = 0; i < previous.length; i++) {
    for (int j = 0; j < previous.length; j++) {
      if (previous[i] + previous[j] == number) {
        return true;
      }
    }
  }
  return false;
}

int getFirstInvalid(List<int> input) {
  for (int i = 25; i < input.length; i++) {
    if (!isCorrect(input[i], input.sublist(i - 25, i))) {
      return input[i];
    }
  }
  return -1;
}

int getEncryptionWeakness(int number, List<int> input) {
    for (int i = 0; i < input.length-2; i++) {
      for (int j = i + 2; j < input.length; j++) {
        var sublist = input.sublist(i, j);
        var sum = sublist.reduce((a,b) => a + b);
        if (sum == number) {
          sublist.sort();
          return sublist[0] + sublist[sublist.length-1];
        }
      }
    }
    return -1;
}

main() {
  var input = <int>[];
  new File("input.txt")
    .openRead()
    .map(utf8.decode)
    .transform(new LineSplitter())
    .forEach((l) => input.add(int.parse(l)))
    .then((x) {
      var invalid = getFirstInvalid(input);
      print("Solution 1: " + invalid.toString());
      print("Solution 2: " + getEncryptionWeakness(invalid, input).toString());
    });
}