import 'package:flutter/material.dart';

import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';

  void _handleButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        _input = _calculateResult();
      } else if (buttonText == 'C') {
        _input = '';
      } else if (buttonText == '√') {
        _input = _calculateSquareRoot();
      }else if (buttonText == 'sin') {
        _input = _calculateSin();
      }else if (buttonText == 'cos') {
        _input = _calculateCos();
      }
      else if (buttonText == 'log') {
        _input = _calculateLog();
      }else if (buttonText == 'X^2') {
        _input = _calculateSquare();
      }
      else {
        _input += buttonText;
      }
    });
  }

  String _calculateResult() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_input);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      return result.toStringAsFixed(2); // Format result to two decimal places
    } catch (e) {
      return 'Error';
    }
  }

  String _calculateSquareRoot() {
    try {
      Parser p = Parser();
      Expression exp = p.parse('sqrt($_input)');
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      if (result.isNaN) {
        return 'Error';
      }
      return result.toStringAsFixed(2);
    } catch (e) {
      return 'Error';
    }
  }
  String _calculateSin() {
    try {
      Parser p = Parser();
      Expression exp = p.parse('sin($_input)');
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      return result.toStringAsFixed(2);
    } catch (e) {
      return 'Error';
    }
  }
  String _calculateCos() {
    try {
      Parser p = Parser();
      Expression exp = p.parse('cos($_input)');
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      return result.toStringAsFixed(2);
    } catch (e) {
      return 'Error';
    }
  }
  String _calculateLog() {
    try {
      Parser p = Parser();
      Expression exp = p.parse('log($_input)');
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      return result.toStringAsFixed(2);
    } catch (e) {
      return 'Error';
    }
  }
  String _calculateSquare() {
    try {
      Parser p = Parser();
      Expression exp = p.parse('($_input)^2');
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      return result.toStringAsFixed(2);
    } catch (e) {
      return 'Error';
    }
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF22252D),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(32),
              alignment: Alignment.bottomRight,
              child: Text(
                _input,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 248, 246, 246),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF2E3139),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                children: [
                  _buildButtonRow(['C','sin','cos','log']),
                  _buildButtonRow(['X^2', '√', '%', '/']),
                  _buildButtonRow(['7', '8', '9', 'x']),
                  _buildButtonRow(['4', '5', '6', '-']),
                  _buildButtonRow(['1', '2', '3', '+']),
                  _buildButtonRow(['0', '.', '=']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttonLabels) {
    return Expanded(
      child: Row(
        children: buttonLabels
            .map((label) => Expanded(child: _buildButton(label)))
            .toList(),
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return Container(
      margin: EdgeInsets.all(3),
      child: ElevatedButton(
        onPressed: () => _handleButtonPressed(buttonText),
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF7F7F85),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    ),
  );
}
