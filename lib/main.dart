import 'package:flutter/material.dart';
import 'package:personal_expenses/pages/home.dart';

void main() {
  return runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.green,
        fontFamily: 'HindMadurai',
        textTheme: TextTheme(
          headline4: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headline5: TextStyle(
            fontSize: 48,
            fontFamily: 'Chivo',
            fontWeight: FontWeight.bold,
            color: Colors.grey[500],
          ),
          headline6: TextStyle(
            fontSize: 16,
            fontFamily: 'Chivo',
            fontWeight: FontWeight.normal,
            color: Colors.grey[400],
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline6: TextStyle(
                fontSize: 18, fontFamily: 'Chivo', fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
