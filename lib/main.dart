import 'package:flutter/material.dart';
import 'package:calcul_mental_flutter/screens/input_page.dart';

void main() => runApp(CalcMental());

class CalcMental extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF0A0E21),
          scaffoldBackgroundColor: Color(0xFF0A0E21)),
      home: InputPage(),
    );
  }
}
