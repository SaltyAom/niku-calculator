import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:provider/provider.dart';

import 'package:niku/niku.dart';

import '../models/calculator.dart';

import '../services/number.dart';
import '../services/theme.dart';

class CalculatorLayout extends StatelessWidget {
  static const operations = [
    "AC",
    "+/-",
    "%",
    "/",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    "00",
    ".",
    "=",
  ];

  static const _operator = ["+", "-", "x", "/", "%"];

  @override
  build(context) => GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        children: calculatorBuilder(context, operations),
      ).niku().fullWidth().aspectRatio(4 / 5).build();

  static List<Widget> calculatorBuilder(context, List<String> operations) {
    final calculator = Provider.of<Calculator>(context, listen: false);

    final Color highlightColor = isDarkTheme(context)
        ? Colors.white.withOpacity(.0375)
        : Colors.black.withOpacity(.0375);

    return List.generate(
      operations.length,
      (index) {
        final operation = operations[index];
        final callback = operation != ""
            ? () {
                handle(calculator, operation);
              }
            : () {};

        return NikuButton(
          NikuText(
            operations[index],
          ).fontSize(24).color(Colors.grey).build(),
        ).onPressed(callback).splash(highlightColor).rounded(8).niku().build();
      },
    );
  }

  static void handle(Calculator calculator, String option) {
    if (isNumeric(option) || option == ".") return calculator.append(option);
    if (option == "AC") return calculator.reset();
    if (_operator.contains(option)) return calculator.operation(option);
    if (option == "=") return calculator.showAnswer();
    if (option == "+/-") return calculator.reverse();
  }
}
