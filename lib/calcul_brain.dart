import 'dart:math';
import 'package:charcode/charcode.dart';

class CalculBrain {
  CalculBrain(
      {this.operand1Min,
      this.operand1Max,
      this.operand2Min,
      this.operand2Max,
      this.chosenOperation,
      this.numberOperation});

  final int operand1Min;
  final int operand1Max;
  final int operand2Min;
  final int operand2Max;
  final String chosenOperation;
  final int numberOperation;

  var currentOperationResult = new Map();
  var operationsResults = new Map();

  int currentOperand1;
  int currentOperand2;

  // Get the operand function
  int operandGet(int minNumber, int maxNumber) {
    return (Random().nextDouble() * (maxNumber - minNumber + 1) + minNumber)
        .floor();
  }

  // Get the operation Text function
  String operationTextGet() {
    currentOperand1 = operandGet(operand1Min, operand1Max);
    currentOperand2 = operandGet(operand2Min, operand2Max);
    String currentOperation;

    switch (chosenOperation) {
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
          if (currentOperand2 == 0) {
            // We must avoid a division by zero!!
            currentOperand2++;
          }
        }
        break;
    }

    return ('$currentOperand1 $currentOperation $currentOperand2 =');
  }

  // Check the result function
  bool resultCheck({int result, int reminder, int currentOperation}) {
    int calcResult;
    int calcReminder;

    currentOperationResult.clear();
    switch (chosenOperation) {
      case 'Addition':
        {
          calcResult = currentOperand1 + currentOperand2;
        }
        break;
      case 'Soustraction':
        {
          calcResult = currentOperand1 - currentOperand2;
        }
        break;
      case 'Multiplication':
        {
          calcResult = currentOperand1 * currentOperand2;
        }
        break;
      case 'Division':
        {
          calcResult = currentOperand1 ~/ currentOperand2;
          calcReminder = currentOperand1 % currentOperand2;
          currentOperationResult['givenReminder'] = reminder;
          currentOperationResult['calcReminder'] = calcReminder;
        }
        break;
    }
    currentOperationResult['operand1'] = currentOperand1;
    currentOperationResult['operand2'] = currentOperand2;
    currentOperationResult['givenResult'] = result;
    currentOperationResult['calcResult'] = calcResult;
    operationsResults[currentOperation] = Map.from(currentOperationResult);

    if (chosenOperation != 'Division') {
      return (result == calcResult);
    } else {
      return (result == calcResult && reminder == calcReminder);
    }
  }

  // get the incentive text
  T getincentiveText<T>(List<T> list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
  }

  void initMap() {
    operationsResults.clear();
  }
}
