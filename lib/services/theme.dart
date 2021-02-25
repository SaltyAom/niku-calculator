import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final isDarkTheme = (BuildContext context) => MediaQuery.of(context).platformBrightness == Brightness.dark;
