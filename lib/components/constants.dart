import 'package:flutter/material.dart';

const Color kActiveCardColor = Color(0xFF1D1E33);
const Color kInactiveCardColor = Color(0xFF111328);

const kLabelTextStyle = TextStyle(
  fontSize: 18.0,
  color: Color(0xFF8D8E98),
);

const kOpeChosenTextStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
const kNumberTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.w900,
);

const kLargeButtonTextStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);

const kTitleTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.bold,
);

const TextStyle kResultOKTextStyle = TextStyle(
  color: Color(0xFF24D876),
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);

const TextStyle kResultNokTextStyle = TextStyle(
  color: Colors.red,
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);

const kBodyTextStyle = TextStyle(
  fontSize: 22.0,
);

const kOperandTextStyle = TextStyle(
  fontSize: 16.0,
  color: Color(0xFF8D8E98),
);

const kOperationExamStyle = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.bold,
);

const kDivisonExamStyle = TextStyle(
  fontSize: 10.0,
  fontWeight: FontWeight.bold,
);

const kCardTitleTextStyle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
);

const kBottomContainerHeight = 50.0;
const Color kBottomContainerColor = Color(0xFFEB1555);

// Results Lists for each questions
const List<String> kListCorrectAnswers = [
  'Bien joué !',
  'Réponse correcte',
  'Tu as donné la bonne réponse',
  'Tu es un as du calcul mental',
  'Super, continue comme cela',
];

const List<String> kListFalseAnswers = [
  'Dommage',
  'Ta réponse est erronée',
  'Ne lâche rien',
  'Essaie encore',
  'Concentre toi',
];

const String kIncentivePositivText = 'Bien joué!';
const String kIncentiveNegativeText = 'Dommage...';
