import 'package:calcul_mental_flutter/components/constants.dart';
import 'package:calcul_mental_flutter/components/reusable_card.dart';
import 'package:calcul_mental_flutter/screens/exam_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:calcul_mental_flutter/components/roundIconContent.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:calcul_mental_flutter/components/bottom_button.dart';
import 'package:calcul_mental_flutter/calcul_brain.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String chosenOperation;
  int numberOperation;
  int operand1Min;
  int operand1Max;
  int operand2Min;
  int operand2Max;

  double doubleOperand1Min;
  double doubleOperand1Max;
  double doubleOperand2Min;
  double doubleOperand2Max;

  void initializeParameters() {
    chosenOperation = 'Addition';
    numberOperation = 5;
    operand1Min = 5;
    operand1Max = 20;
    operand2Min = 5;
    operand2Max = 20;
    doubleOperand1Min = 5.0;
    doubleOperand1Max = 20.0;
    doubleOperand2Min = 5.0;
    doubleOperand2Max = 20.0;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeParameters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CALCUL MENTAL',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.syncAlt),
            tooltip: 'Réinitialiser les paramètres',
            onPressed: () {
              setState(() {
                initializeParameters();
              });
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ReusableCard(
              colour: kActiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'Opération choisie:  ',
                        style: kLabelTextStyle,
                      ),
                      Text(
                        '$chosenOperation',
                        style: kOpeChosenTextStyle,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundIconButton(
                          icon: FontAwesomeIcons.plus,
                          onPressed: () {
                            setState(() {
                              chosenOperation = 'Addition';
                            });
                          }),
                      SizedBox(width: 10.0),
                      RoundIconButton(
                          icon: FontAwesomeIcons.minus,
                          onPressed: () {
                            setState(() {
                              chosenOperation = 'Soustraction';
                            });
                          }),
                      SizedBox(width: 10.0),
                      RoundIconButton(
                          icon: FontAwesomeIcons.times,
                          onPressed: () {
                            setState(() {
                              chosenOperation = 'Multiplication';
                            });
                          }),
                      SizedBox(width: 10.0),
                      RoundIconButton(
                          icon: FontAwesomeIcons.divide,
                          onPressed: () {
                            setState(() {
                              chosenOperation = 'Division';
                            });
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ReusableCard(
            colour: kActiveCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'Nombre de calculs:  ',
                      style: kLabelTextStyle,
                    ),
                    Text(
                      '$numberOperation',
                      style: kOpeChosenTextStyle,
                    )
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    inactiveTrackColor: Color(0xFF8D8E98),
                    activeTrackColor: Colors.white,
                    thumbColor: Color(0xFFEB1555),
                    overlayColor: Color(0x29EB1555),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                  ),
                  child: Slider(
                    value: numberOperation.toDouble(),
                    min: 2.0,
                    max: 20.0,
                    onChanged: (double newValue) {
                      setState(() {
                        numberOperation = newValue.round();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          ReusableCard(
            colour: kActiveCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Premier Nombre',
                  style: kLabelTextStyle,
                ),
                Row(
                  children: [
                    Text(
                      'Min: ',
                      style: kOperandTextStyle,
                    ),
                    Text(
                      '$operand1Min',
                      style: kOpeChosenTextStyle,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Max: ',
                      style: kOperandTextStyle,
                    ),
                    Text(
                      '$operand1Max',
                      style: kOpeChosenTextStyle,
                    ),
                  ],
                ),
                FlutterSlider(
                  trackBar: FlutterSliderTrackBar(
                    inactiveTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFF8D8E98),
                    ),
                    activeTrackBar: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  handler: FlutterSliderHandler(
                    decoration: BoxDecoration(
                      color: Color(0xFFEB1555),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  rightHandler: FlutterSliderHandler(
                    decoration: BoxDecoration(
                      color: Color(0xFFEB1555),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  values: [doubleOperand1Min, doubleOperand1Max],
                  rangeSlider: true,
                  max: 30,
                  min: 0,
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    doubleOperand1Min = lowerValue;
                    doubleOperand1Max = upperValue;
                    setState(() {
                      operand1Min = doubleOperand1Min.round();
                      operand1Max = doubleOperand1Max.round();
                    });
                  },
                ),
              ],
            ),
          ),
          ReusableCard(
            colour: kActiveCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Deuxième Nombre',
                  style: kLabelTextStyle,
                ),
                Row(
                  children: [
                    Text(
                      'Min: ',
                      style: kOperandTextStyle,
                    ),
                    Text(
                      '$operand2Min',
                      style: kOpeChosenTextStyle,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Max: ',
                      style: kOperandTextStyle,
                    ),
                    Text(
                      '$operand2Max',
                      style: kOpeChosenTextStyle,
                    ),
                  ],
                ),
                FlutterSlider(
                  trackBar: FlutterSliderTrackBar(
                    inactiveTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFF8D8E98),
                    ),
                    activeTrackBar: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  handler: FlutterSliderHandler(
                    decoration: BoxDecoration(
                      color: Color(0xFFEB1555),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  rightHandler: FlutterSliderHandler(
                    decoration: BoxDecoration(
                      color: Color(0xFFEB1555),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  values: [doubleOperand2Min, doubleOperand2Max],
                  rangeSlider: true,
                  max: 30,
                  min: 0,
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    doubleOperand2Min = lowerValue;
                    doubleOperand2Max = upperValue;
                    setState(() {
                      operand2Min = doubleOperand2Min.round();
                      operand2Max = doubleOperand2Max.round();
                    });
                  },
                ),
              ],
            ),
          ),
          BottomButton(
            onTap: () {
              CalculBrain dataCalcul = CalculBrain(
                operand1Min: operand1Min,
                operand1Max: operand1Max,
                operand2Min: operand2Min,
                operand2Max: operand2Max,
                chosenOperation: chosenOperation,
                numberOperation: numberOperation,
              );
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ExamPage(
                  dataCalcul: dataCalcul,
                );
              }));
            },
            buttonTitle: 'DEMARRER',
          ),
        ],
      ),
    );
  }
}
