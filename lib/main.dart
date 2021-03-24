import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:niku/niku.dart';

import './models/calculator.dart';

import './components/calculator.dart';

import './services/number.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Calculator(),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  build(context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    final Color lightTheme = Color.fromRGBO(48, 48, 48, 1);
    final Color darkTheme = Color.fromRGBO(250, 250, 250, 1);

    return MaterialApp(
      title: 'Niku Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        backgroundColor: lightTheme,
        appBarTheme: AppBarTheme(brightness: Brightness.light),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
        backgroundColor: darkTheme,
        appBarTheme: AppBarTheme(brightness: Brightness.dark),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  build(context) {
    final calculator = Provider.of<Calculator>(context);

    return Scaffold(
      body: SafeArea(
        child: NikuColumn([
          Text(calculator.mathOperation).asNiku()
            ..color(Colors.blue)
            ..fontSize(28)
            ..bold()
            ..right()
            ..mr(20),
          Text(formatComma(calculator.value))
              .asNiku()
              .fontSize(60)
              .right()
              .maxLines(2)
              .overflow(TextOverflow.ellipsis)
              .niku()
                ..p(20)
                ..on(tap: () {
                  calculator.decrease();
                }),
          CalculatorLayout()
        ])
          ..justifyEnd()
          ..stretch()
          ..mb(20),
      ),
    );
  }
}
