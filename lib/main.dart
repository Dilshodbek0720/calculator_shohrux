import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My calculator',
      home: CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  final TextEditingController _txt = TextEditingController(text: '0');
  String a = '';
  String b = '';
  String oper = '';
  double result = 0;

  void btnPressed(String btnText) {

    if(_txt.text == '0' && btnText == '0'){
      print(_txt.text == '0');
      print("A: ${btnText == '0'}");
      print(_txt.text);
      _txt.text = '0';
      result = 0;
    }

    if (btnText == 'C') {
      _txt.text = '0';
      a = '';
      b = '';
      oper = '';
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == '*' ||
        btnText == '/') {
      oper = btnText;
    } else if (btnText == '=') {
      double x = double.parse(a);
      double y = double.parse(b);
      switch (oper) {
        case '+':
          result = x + y;
          break;
        case '-':
          result = x - y;
          break;
        case '*':
          result = x * y;
          break;
        case '/':
          result = x / y;
          break;
      }

      String z = result.toString();
      int n = z.length;

      if (z[n - 1] == '0' && z[n - 2] == '.') {
        _txt.text = z.substring(0, z.length - 2);
      } else {
        _txt.text = z;
      }
      a = '';
      b = '';
      oper = '';
    } else {
      if (oper == '') {
        a += btnText;
        _txt.text = a;
      } else {
        b += btnText;
        _txt.text = b;
      }
    }
  }

  Widget createButton(String btnText, Color textColor, Color btnColor) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          btnPressed(btnText);
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(20),
      ),
      child: Text(
        btnText,
        style: TextStyle(
          fontSize: 24,
          color: textColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator by Shohrux"),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 25,),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${a.isEmpty ? '' : a} ${oper.isEmpty ? '' : oper} ${b.isEmpty ? '' : b}",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      _txt.text,
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),),
              Expanded(child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: createButton('C', Colors.white, Colors.green),
              )),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.count(
                childAspectRatio: 1.15,
                crossAxisCount: 4,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                children: [
                  createButton('1', Colors.white, Colors.green),
                  createButton('2', Colors.white, Colors.green),
                  createButton('3', Colors.white, Colors.green),
                  createButton('/', Colors.white, Colors.green),
                  createButton('4', Colors.white, Colors.green),
                  createButton('5', Colors.white, Colors.green),
                  createButton('6', Colors.white, Colors.green),
                  createButton('*', Colors.white, Colors.green),
                  createButton('7', Colors.white, Colors.green),
                  createButton('8', Colors.white, Colors.green),
                  createButton('9', Colors.white, Colors.green),
                  createButton('-', Colors.white, Colors.green),
                  createButton('0', Colors.white, Colors.green),
                  createButton('.', Colors.white, Colors.green),
                  createButton('=', Colors.white, Colors.green),
                  createButton('+', Colors.white, Colors.green),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
