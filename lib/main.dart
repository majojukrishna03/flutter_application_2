import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

abstract class CalculatorOperations {
  double add(double num1, double num2);
  double subtract(double num1, double num2);
  double multiply(double num1, double num2);
  double divide(double num1, double num2);
}

class Calculator implements CalculatorOperations {
  @override
  double add(double num1, double num2) {
    return num1 + num2;
  }

  @override
  double subtract(double num1, double num2) {
    return num1 - num2;
  }

  @override
  double multiply(double num1, double num2) {
    return num1 * num2;
  }

  @override
  double divide(double num1, double num2) {
    if (num2 != 0) {
      return num1 / num2;
    } else {
      throw ArgumentError("Cannot divide by zero");
    }
  }
}

class CalculatorApp extends StatelessWidget {
  final Calculator calculator = Calculator();
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();
  String _result = '';

  void _calculate(String operation) {
    double num1 = double.tryParse(_num1Controller.text) ?? 0.0;
    double num2 = double.tryParse(_num2Controller.text) ?? 0.0;
    double? result = null;

    switch (operation) {
      case 'add':
        result = calculator.add(num1, num2);
        break;
      case 'subtract':
        result = calculator.subtract(num1, num2);
        break;
      case 'multiply':
        result = calculator.multiply(num1, num2);
        break;
      case 'divide':
        try {
          result = calculator.divide(num1, num2);
        } catch (e) {
          _result = "Error: ${e.toString()}";
        }
        break;
    }

    if (result != null) {
      _result = 'Result: $result';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculator App'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _num1Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter number 1'),
              ),
              TextField(
                controller: _num2Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter number 2'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _calculate('add'),
                child: Text('+'),
              ),
              ElevatedButton(
                onPressed: () => _calculate('subtract'),
                child: Text('-'),
              ),
              ElevatedButton(
                onPressed: () => _calculate('multiply'),
                child: Text('*'),
              ),
              ElevatedButton(
                onPressed: () => _calculate('divide'),
                child: Text('/'),
              ),
              SizedBox(height: 16.0),
              Text(_result),
            ],
          ),
        ),
      ),
    );
  }
}
