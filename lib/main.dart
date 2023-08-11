import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notes.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/calculator': (context) => CalculatorScreen(),
        '/notes': (context) => NotesScreen(),
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to our App!",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/drama.jpeg', // Replace with the actual image path
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/calculator');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent, // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: Text("Calculator"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotesScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent, // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: Text("Notes"),
            ),
          ],
        ),
      ),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  double _num1 = 0;
  double _num2 = 0;
  String _operator = "";
  bool _isOperatorChosen = false;

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _num1 = 0;
        _num2 = 0;
        _operator = "";
        _isOperatorChosen = false;
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "*" ||
          buttonText == "/") {
        if (_isOperatorChosen) {
          _calculateResult();
        }
        _num1 = double.parse(_output);
        _operator = buttonText;
        _isOperatorChosen = true;
      } else if (buttonText == "=") {
        _calculateResult();
      } else {
        if (_output == "0" || _isOperatorChosen) {
          _output = buttonText;
          _isOperatorChosen = false;
        } else {
          _output += buttonText;
        }
      }
    });
  }

  void _calculateResult() {
    if (_num1 != 0 && _operator.isNotEmpty) {
      _num2 = double.parse(_output);
      switch (_operator) {
        case "+":
          _output = (_num1 + _num2).toString();
          break;
        case "-":
          _output = (_num1 - _num2).toString();
          break;
        case "*":
          _output = (_num1 * _num2).toString();
          break;
        case "/":
          if (_num2 != 0) {
            _output = (_num1 / _num2).toString();
          } else {
            _output = "Error";
          }
          break;
        default:
          _output = "Error";
      }
      _num1 = double.parse(_output);
      _num2 = 0;
      _operator = "";
      _isOperatorChosen = false;
    }
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 6, 131, 241), // Button color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0), // Button border radius
            ),
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Calculator"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.bottomRight,
                child: Text(
                  _output,
                  style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                _buildButton("7"),
                _buildButton("8"),
                _buildButton("9"),
                _buildButton("/"),
              ],
            ),
            Row(
              children: [
                _buildButton("4"),
                _buildButton("5"),
                _buildButton("6"),
                _buildButton("*"),
              ],
            ),
            Row(
              children: [
                _buildButton("1"),
                _buildButton("2"),
                _buildButton("3"),
                _buildButton("-"),
              ],
            ),
            Row(
              children: [
                _buildButton("0"),
                _buildButton("C"),
                _buildButton("="),
                _buildButton("+"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
