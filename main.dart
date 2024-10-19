import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      title: 'Calculator',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[600], // Light dark blue
        scaffoldBackgroundColor: Colors.black, // Set background color to black
      ),
      home: const CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({Key? key}) : super(key: key);

  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _display = '0';
  String _input = '';
  double _firstNumber = 0;
  double _secondNumber = 0;
  String _operation = '';

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _clearAll();
      } else if (value == '⌫') {
        _input = _input.isNotEmpty ? _input.substring(0, _input.length - 1) : '';
        _display = _input.isEmpty ? '0' : _input;
      } else if (value == '+' || value == '-' || value == '×' || value == '÷') {
        if (_input.isNotEmpty) {
          _firstNumber = double.parse(_input);
          _operation = value;
          _input = '';
        }
      } else if (value == '=') {
        if (_input.isNotEmpty && _operation.isNotEmpty) {
          _secondNumber = double.parse(_input);
          _calculateResult();
        }
      } else {
        _input += value;
        _display = _input;
      }
    });
  }

  void _clearAll() {
    _display = '0';
    _input = '';
    _firstNumber = 0;
    _secondNumber = 0;
    _operation = '';
  }

  void _calculateResult() {
    double result = 0;
    switch (_operation) {
      case '+':
        result = _firstNumber + _secondNumber;
        break;
      case '-':
        result = _firstNumber - _secondNumber;
        break;
      case '×':
        result = _firstNumber * _secondNumber;
        break;
      case '÷':
        if (_secondNumber != 0) {
          result = _firstNumber / _secondNumber;
        } else {
          _display = 'Error';
          _input = '';
          return;
        }
        break;
    }
    _display = result.toString();
    _input = result.toString();
    _operation = '';
  }

  Widget _buildButton(String text, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(text),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            shape: const CircleBorder(),
            backgroundColor: color,
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.lightBlue[600], // Light dark blue for AppBar
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            child: Text(
              _display,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w500, color: Colors.white), // Change display text color to white for better contrast
            ),
          ),
          const Divider(color: Colors.grey),
          Expanded(
            child: Column(
              children: [
                _buildButtonRow(['7', '8', '9', '÷'], Colors.blueGrey),
                _buildButtonRow(['4', '5', '6', '×'], Colors.blueGrey),
                _buildButtonRow(['1', '2', '3', '-'], Colors.blueGrey),
                _buildButtonRow(['C', '0', '⌫', '+'], Colors.blueGrey),
                _buildButtonRow(['='], Colors.blueAccent),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _buildButtonRow(List<String> buttons, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((text) => _buildButton(text, color)).toList(),
    );
  }
}
