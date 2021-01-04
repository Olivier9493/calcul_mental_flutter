import 'package:flutter/material.dart';
import 'package:calcul_mental_flutter/components/constants.dart';
import 'package:calcul_mental_flutter/components/reusable_card.dart';
import 'package:calcul_mental_flutter/calcul_brain.dart';
import 'package:calcul_mental_flutter/components/bottom_button.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'result_page.dart';

class ExamPage extends StatefulWidget {
  ExamPage({this.dataCalcul});

  final CalculBrain dataCalcul;

  @override
  _ExamPageState createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  int currentOperation = 1;
  String operationText;
  int currentScore = 0;
  int proposedResult;
  int proposedReminder;
  int correctResult;
  int correctReminder;
  String resultSentence = ' ';
  String incentiveText = ' ';
  FaIcon incentiveIcon = FaIcon(
    FontAwesomeIcons.pauseCircle,
    color: Colors.white,
  );
  String titleButton = '';
  bool inputEnable = true;
  TextStyle incentiveTextStyle;

  final resultHolder = TextEditingController();
  final reminderHolder = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    operationText = widget.dataCalcul.operationTextGet();
    titleButton = titleBottomButton();
  }

  Widget exerciceStandardWidget() {
    return (Expanded(
      child: TextField(
        style: kOperationExamStyle,
        controller: resultHolder,
        onChanged: (value) {
          proposedResult = int.parse(value);
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: '0',
          helperText: 'Résultat de l\'opération',
          enabled: inputEnable,
        ),
        keyboardType:
            TextInputType.numberWithOptions(signed: true, decimal: true),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      ),
    ));
  }

  Widget exerciceDivisionWidget() {
    return Expanded(
      child: (Column(
        children: [
          TextField(
            style: kDivisonExamStyle,
            controller: resultHolder,
            onChanged: (value) {
              proposedResult = int.parse(value);
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: '0',
              helperText: 'Quotient de la division',
              enabled: inputEnable,
            ),
            keyboardType:
                TextInputType.numberWithOptions(signed: true, decimal: true),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          TextField(
            style: kDivisonExamStyle,
            controller: reminderHolder,
            onChanged: (value1) {
              proposedReminder = int.parse(value1);
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: '0',
              helperText: 'Reste de la division',
              enabled: inputEnable,
            ),
            keyboardType:
            TextInputType.numberWithOptions(signed: true, decimal: true),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          )
        ],
      )),
    );
  }

  Widget textCurrentOperation() {
    String textCurrentOperation;
    if (currentOperation > widget.dataCalcul.numberOperation) {
      textCurrentOperation = '${widget.dataCalcul.numberOperation}';
    } else {
      textCurrentOperation = '$currentOperation';
    }
    return (Text(
      '$textCurrentOperation',
      style: kOpeChosenTextStyle,
    ));
  }

  String titleBottomButton() {
    if (currentOperation >= widget.dataCalcul.numberOperation + 1) {
      return ('RECAPITULATIF');
    } else {
      return ('EVALUER');
    }
  }

  void resultEvaluation() {
    setState(() {
      if (widget.dataCalcul.resultCheck(
          result: proposedResult,
          reminder: proposedReminder,
          currentOperation: currentOperation)) {
        incentiveText = widget.dataCalcul.getincentiveText(kListCorrectAnswers);
        incentiveIcon = FaIcon(
          FontAwesomeIcons.grin,
          color: Colors.green,
        );
        incentiveTextStyle = kResultOKTextStyle;
        currentScore++;
        correctResult =
            widget.dataCalcul.operationsResults[currentOperation]['calcResult'];
        correctReminder = widget.dataCalcul.operationsResults[currentOperation]
            ['calcReminder'];
      } else {
        incentiveText = widget.dataCalcul.getincentiveText(kListFalseAnswers);
        incentiveIcon = FaIcon(
          FontAwesomeIcons.frown,
          color: Colors.red,
        );
        incentiveTextStyle = kResultNokTextStyle;
      }
      correctResult =
          widget.dataCalcul.operationsResults[currentOperation]['calcResult'];
      correctReminder =
          widget.dataCalcul.operationsResults[currentOperation]['calcReminder'];
      if (widget.dataCalcul.chosenOperation == 'Division') {
        resultSentence =
            'Le quotient est : $correctResult - Le reste: $correctReminder';
      } else {
        resultSentence = 'Le résultat est: $correctResult';
      }
      currentOperation++;
      titleButton = titleBottomButton();
      proposedResult = 0;
      proposedReminder = 0;
      resultHolder.clear();
      reminderHolder.clear();
      if (currentOperation > widget.dataCalcul.numberOperation) {
        inputEnable = false;
        operationText = 'Fin de l\'exercice';
      } else {
        operationText = widget.dataCalcul.operationTextGet();
      }
    });
  }

  void overviewDisplay() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ResultPage(
        dataCalcul: widget.dataCalcul,
        exerciceScore: currentScore,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'EXERCICES: ${widget.dataCalcul.chosenOperation}',
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ReusableCard(
            colour: kActiveCardColor,
            cardChild: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Synthèse de l\'examen',
                  style: kCardTitleTextStyle,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(children: [
                  Text('Calcul Nr: ', style: kLabelTextStyle),
                  textCurrentOperation(),
                  Text(
                    ' / ',
                    style: kLabelTextStyle,
                  ),
                  Text(
                    '${widget.dataCalcul.numberOperation}',
                    style: kOpeChosenTextStyle,
                  ),
                  SizedBox(width: 25.0),
                  Text(
                    'Score: ',
                    style: kLabelTextStyle,
                  ),
                  Text(
                    '$currentScore',
                    style: kOpeChosenTextStyle,
                  ),
                ]),
              ],
            ),
          ),
          Expanded(
            child: ReusableCard(
              colour: kActiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Question actuelle',
                    style: kCardTitleTextStyle,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: Text(
                          '$operationText',
                          style: kOperationExamStyle,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      SizedBox(width: 15.0),
                      widget.dataCalcul.chosenOperation == 'Division'
                          ? exerciceDivisionWidget()
                          : exerciceStandardWidget(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ReusableCard(
              colour: kActiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Résultat de la question précédente (N° ${currentOperation - 1} )',
                    style: kCardTitleTextStyle,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      IconButton(icon: incentiveIcon, onPressed: null),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Text(
                          '$incentiveText',
                          style: incentiveTextStyle,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '$resultSentence',
                    style: kResultOKTextStyle,
                  )
                ],
              ),
            ),
          ),
          BottomButton(
            onTap: () {
              if (inputEnable) {
                resultEvaluation();
              } else {
                overviewDisplay();
              }
            },
            buttonTitle: titleBottomButton(),
          ),
        ],
      ),
    );
  }
}
