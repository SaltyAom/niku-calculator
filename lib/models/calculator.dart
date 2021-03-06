import 'package:flutter/material.dart';

class Calculator extends ChangeNotifier {
  String _firstValue = "0";
  String _secondValue = "0";

  bool _operating = false;
  String _mathOperation = "";

  bool _isReadyToOperate = false;

  String get value => !_operating ? _firstValue : _secondValue;
  bool get operating => _operating;
  String get mathOperation => _mathOperation;

  void append(String input) {
    if (input == "." && value.contains(".")) {
      return;
    } else if (isStart && input == "00") {
      return;
    }

    if (_isReadyToOperate) {
      _operating = true;
      _isReadyToOperate = false;
    }

    String number = isStart && input == "." ? "0." : input;

    String variable = !_operating ? _firstValue : _secondValue;
    String calculated = isStart
        ? isNegative(number)
            ? "-$number"
            : number
        : variable + number;

    if (!_operating)
      _firstValue = calculated;
    else
      _secondValue = calculated;

    notifyListeners();
  }

  bool get isStart {
    String value = !_operating ? _firstValue : _secondValue;

    return value == "0" || value == "-0";
  }

  bool isNegative(String value) => value.startsWith("-");

  void reset() {
    _firstValue = "0";
    _secondValue = "0";

    _operating = false;
    _mathOperation = "";

    _isReadyToOperate = false;

    notifyListeners();
  }

  void operation(String mathOperation) {
    _mathOperation = mathOperation;

    _isReadyToOperate = true;

    notifyListeners();
  }

  void showAnswer() {
    if (_operating == false) return;

    _operating = false;

    _firstValue = operate();
    _secondValue = "0";

    _mathOperation = "";

    notifyListeners();
  }

  String operate() {
    double calculated = 0;

    if (_mathOperation == "+")
      calculated = double.parse(_firstValue) + double.parse(_secondValue);
    else if (_mathOperation == "-")
      calculated = double.parse(_firstValue) - double.parse(_secondValue);
    else if (_mathOperation == "x")
      calculated = double.parse(_firstValue) * double.parse(_secondValue);
    else if (_mathOperation == "/")
      calculated = double.parse(_firstValue) / double.parse(_secondValue);
    else if (_mathOperation == "%")
      calculated = double.parse(_firstValue) % double.parse(_secondValue);

    String parsed = "$calculated";
    parsed = parsed.endsWith(".0") || parsed.endsWith(".")
        ? calculated.toStringAsFixed(0)
        : parsed;

    return parsed;
  }

  void reverse() {
    if (!operating)
      _firstValue = _reverse(_firstValue);
    else
      _secondValue = _reverse(_secondValue);

    notifyListeners();
  }

  String _reverse(String value) =>
      value.startsWith("-") ? value.substring(1) : "-" + value;

  void decrease() {
    String variable = !_operating ? _firstValue : _secondValue;

    String calculated =
        variable.length <= 1 || (variable.contains("-") && variable.length <= 2)
            ? variable.contains("-")
                ? "-0"
                : "0"
            : variable.substring(0, variable.length - 1);

    if (!_operating) {
      _firstValue = calculated;
    } else {
      _secondValue = calculated;
    }

    notifyListeners();
  }
}
