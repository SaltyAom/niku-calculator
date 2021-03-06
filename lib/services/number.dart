bool isNumeric(String s) {
  return double.tryParse(s) != null;
}

String formatComma(String input) {
  if (!isNumeric(input)) return input;

  double number = double.parse(input);

  bool isNegative = input.startsWith("-");

  List<String> parsed = input.split("");

  int i = 0;

  int numberLength = number.toStringAsFixed(0).length;

  if (isNegative) {
    parsed.removeAt(0);
    numberLength--;
  }

  if (numberLength > 3)
    for (int commaPosition = (numberLength % 3).toInt();
        commaPosition + i <= numberLength;
        commaPosition += 3) {
      if (commaPosition == 0) continue;

      parsed.insert(commaPosition + i, ",");
      i++;
    }

  if (isNegative) parsed.insert(0, "-");

  return parsed.join();
}
