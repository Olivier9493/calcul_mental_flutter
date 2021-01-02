import 'package:flutter/material.dart';
import 'package:calcul_mental_flutter/components/constants.dart';
import 'package:calcul_mental_flutter/components/reusable_card.dart';
import 'package:calcul_mental_flutter/calcul_brain.dart';
import 'package:calcul_mental_flutter/components/bottom_button.dart';
import 'package:charcode/charcode.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResultPage extends StatelessWidget {
  ResultPage({this.dataCalcul, this.exerciceScore});

  final CalculBrain dataCalcul;
  final int exerciceScore;

  int percentageScore = 0;
  String interpretation;

  String getInterpretation() {
    if (percentageScore == 100) {
      return 'C\'est parfait. Tu es un champion';
    } else if (percentageScore >= 75) {
      return 'C\'est proche de la perfection';
    } else if (percentageScore >= 50) {
      return 'C\'est encore bon.';
    } else {
      return 'Tu feras mieux la prochaine fois';
    }
  }

  String getOperation(int key) {
    String currentOperation;
    int operand1Read = dataCalcul.operationsResults[key]['operand1'];
    int operand2Read = dataCalcul.operationsResults[key]['operand2'];
    switch (dataCalcul.chosenOperation) {
      case 'Addition':
        {
          currentOperation = '+';
        }
        break;
      case 'Soustraction':
        {
          currentOperation = '-';
        }
        break;
      case 'Multiplication':
        {
          currentOperation = 'x';
        }
        break;
      case 'Division':
        {
          currentOperation = String.fromCharCode($divide);
        }
        break;
    }

    return ('$operand1Read $currentOperation $operand2Read');
  }

  int getResult(int key, String resultType) {
    return dataCalcul.operationsResults[key][resultType];
  }

  Widget overviewAnswer(int key) {
    int givenResult = getResult(key, 'givenResult');
    int rightResult = getResult(key, 'calcResult');
    bool resultCheck = false;
    FaIcon displayedIcon = FaIcon(
      FontAwesomeIcons.frown,
      color: Colors.red,
    );
    String resultText;
    String reminderText;
    String incentiveText;
    if (dataCalcul.chosenOperation == 'Division') {
      int givenReminder = getResult(key, 'givenReminder');
      int rightReminder = getResult(key, 'calcReminder');
      if (givenResult == rightResult && givenReminder == rightReminder) {
        resultCheck = true;
        displayedIcon = FaIcon(
          FontAwesomeIcons.grin,
          color: Colors.green,
        );
        resultText = 'Tu as donné le bon quotient : $rightResult';
        reminderText = 'Tu as calculé le bon reste: $rightReminder';
        incentiveText = kIncentivePositivText;
      } else {
        resultText = 'Ton quotient était de $givenResult pour $rightResult';
        reminderText = 'Ton reste était de $givenReminder pour $rightReminder';
        incentiveText = kIncentiveNegativeText;
      }
      return (Column(
        children: [
          Text(
            resultText,
            style: kLabelTextStyle,
          ),
          Text(
            reminderText,
            style: kLabelTextStyle,
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              IconButton(
                icon: displayedIcon,
                onPressed: null,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                incentiveText,
                style: kLabelTextStyle,
              ),
            ],
          )
        ],
      ));
    } else {
      if (givenResult == rightResult) {
        resultCheck = true;
        displayedIcon = FaIcon(
          FontAwesomeIcons.grin,
          color: Colors.green,
        );
        resultText = 'Tu as donné le bon résultat : $rightResult';
        incentiveText = kIncentivePositivText;
      } else {
        resultText = 'Ton résultat était de $givenResult pour $rightResult';
        incentiveText = kIncentiveNegativeText;
      }
      return (Column(
        children: [
          Text(
            resultText,
            style: kLabelTextStyle,
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              IconButton(
                icon: displayedIcon,
                onPressed: null,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                incentiveText,
                style: kLabelTextStyle,
              ),
            ],
          )
        ],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    percentageScore =
        (exerciceScore / dataCalcul.numberOperation * 100).floor();
    interpretation = getInterpretation();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Résultats de l\'exercice: "${dataCalcul.chosenOperation}"',
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ReusableCard(
            colour: kActiveCardColor,
            cardChild: Column(
              children: [
                Text(
                  'Ton score final est : $exerciceScore sur ${dataCalcul.numberOperation}',
                  style: kLabelTextStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'La réussite est donc de: $percentageScore%',
                  style: kLabelTextStyle,
                ),
                SizedBox(height: 10.0),
                Text(
                  interpretation,
                  style: kLabelTextStyle,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(5),
              itemCount: dataCalcul.operationsResults.length,
              itemBuilder: (BuildContext context, int index) {
                int key = dataCalcul.operationsResults.keys.elementAt(index);
                String exerciceLabel = getOperation(key);
                return ReusableCard(
                  colour: kInactiveCardColor,
                  cardChild: Column(
                    children: [
                      Text(
                        'Exercice $key: $exerciceLabel',
                        style: kLabelTextStyle,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      overviewAnswer(key),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
          BottomButton(
              onTap: () {
                dataCalcul.initMap();
                /*Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return InputPage();
                }));*/
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              buttonTitle: 'On y retourne'),
        ],
      ),
    );
  }
}
