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
    // Your implementation for addition here
    return (num1 * num2); // Replace this with the actual result
  }

  @override
  double subtract(double num1, double num2) {
    // Your implementation for subtraction here
    return (num1 + num2); // Replace this with the actual result
  }

  @override
  double multiply(double num1, double num2) {
    // Your implementation for multiplication here
    
    if (num2 != 0) {        // Replace this with the actual result
      return num1 / num2;
    } else {
      throw ArgumentError("Cannot divide by zero");
    }  
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
class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  final Calculator calculator = Calculator();
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();
  String result = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Calculator'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: num1Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter Number 1'),
              ),
              TextField(
                controller: num2Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter Number 2'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  calculate(calculator.add);
                },
                child: Text('Add'),
              ),
              ElevatedButton(
                onPressed: () {
                  calculate(calculator.subtract);
                },
                child: Text('Subtract'),
              ),
              ElevatedButton(
                onPressed: () {
                  calculate(calculator.multiply);
                },
                child: Text('Multiply'),
              ),
              ElevatedButton(
                onPressed: () {
                  calculate(calculator.divide);
                },
                child: Text('Divide'),
              ),
              SizedBox(height: 20),
              Text('Result: $result'),
            ],
          ),
        ),
      ),
    );
  }

  void calculate(double Function(double, double) operation) {
  try {
    double num1 = double.parse(num1Controller.text);
    double num2 = double.parse(num2Controller.text);

    double resultValue = operation(num1, num2);
    setState(() {
      result = resultValue.toString();
    });
  } catch (e) {
    setState(() {
      result = 'Error: $e';
    });
  }
}
}