// ignore_for_file: avoid_unnecessary_containers, camel_case_types, prefer_interpolation_to_compose_strings, curly_braces_in_flow_control_structures, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(myApp());

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: calculator(),
    );
  }
}

class calculator extends StatefulWidget {
  calculator({super.key});

  @override
  State<calculator> createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {
  String userinput = "0";
  String result = "";
  Color printColor = Colors.blue;
  Widget calcbtn(
      String btntxt, Color btncolor, Color txtcolor, Color printcolor) {
    equalPressed() {
      String userInputFC = userinput;
      userInputFC = userInputFC.replaceAll("x", "*");
      userInputFC = userInputFC.replaceAll('÷', '/');

      Parser p = Parser();
      Expression exp = p.parse(userInputFC);
      ContextModel ctx = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, ctx);

      result = eval.toString().replaceAll(".0", "");
    }

    handlebuttons(String text) {
      if (text == "AC") {
        userinput = "0";
        result = "";
        return;
      }

      if (text == "C") {
        if (userinput.isNotEmpty) {
          userinput = userinput.substring(0, userinput.length - 1);
          String lastString =
              userinput.substring(userinput.length - 1, userinput.length);
          if (lastString != "%" &&
              lastString != "÷" &&
              lastString != "x" &&
              lastString != "-" &&
              lastString != "+" &&
              lastString != "AC" &&
              lastString != "=") {
            equalPressed();
          }
          return;
        } else {
          return null;
        }
      }

      if (text == '=') {
        userinput = result;
        result = '';
      }
      if (text != '=') {
        if (userinput.length == 1 && userinput == '0') {
          userinput = '';
        }
        userinput = userinput + text;
        String lastString =
            userinput.substring(userinput.length - 1, userinput.length);
        if (lastString != "C" &&
            lastString != "%" &&
            lastString != "/" &&
            lastString != "*" &&
            lastString != "-" &&
            lastString != "+" &&
            lastString != "AC" &&
            lastString != "=") {
          setState(() {
            printColor = Colors.white;
          });
          equalPressed();
        } else {
          setState(() {
            printColor = Colors.amberAccent;
          });
        }
      }
    }

    return Container(
      child: ElevatedButton(
          onPressed: () {
            setState(() {
              handlebuttons(btntxt);
            });
          },
          // ignore: sort_child_properties_last
          child: Text(
            btntxt,
            style: TextStyle(
              color: txtcolor,
              fontSize: 35,
            ),
          ),
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: btncolor,
              padding: const EdgeInsets.all(15.0))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 300,
              width: 380,
              child: ListView(
                  // scrollDirection: Axis.horizontal,
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(47.0),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userinput,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: printColor,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28),
              child: Divider(
                color: Color.fromARGB(255, 106, 103, 103),
                thickness: 1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    calcbtn(
                        'AC', Colors.grey[100]!, Colors.black, Colors.white),
                    calcbtn('7', Colors.grey, Colors.black, Colors.white),
                    calcbtn('4', Colors.grey, Colors.black, Colors.white),
                    calcbtn('1', Colors.grey, Colors.black, Colors.white),
                    calcbtn('00', Colors.grey, Colors.black, Colors.white),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    calcbtn('C', Colors.grey[100]!, Colors.black, Colors.white),
                    calcbtn('8', Colors.grey, Colors.black, Colors.white),
                    calcbtn('5', Colors.grey, Colors.black, Colors.white),
                    calcbtn('2', Colors.grey, Colors.black, Colors.white),
                    calcbtn('0', Colors.grey, Colors.black, Colors.white),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    calcbtn('%', Colors.amber, Colors.white, Colors.amber),
                    calcbtn('9', Colors.grey, Colors.black, Colors.white),
                    calcbtn('6', Colors.grey, Colors.black, Colors.white),
                    calcbtn('3', Colors.grey, Colors.black, Colors.white),
                    calcbtn('.', Colors.grey, Colors.black, Colors.white),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    calcbtn('/', Colors.amber, Colors.white, Colors.amber),
                    calcbtn('*', Colors.amber, Colors.white, Colors.amber),
                    calcbtn('-', Colors.amber, Colors.white, Colors.amber),
                    calcbtn('+', Colors.amber, Colors.white, Colors.amber),
                    calcbtn('=', Colors.white, Colors.black, Colors.white),
                  ],
                ),
                // const SizedBox(
                //   height: 5,
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [],
                ),
              ],
            ),
            SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userinput = "";
  String result = "";
  final List<String> ButtonList = [
    'AC',
    'C',
    '%',
    '÷',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '00',
    '0',
    '.',
    '='
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Calculator'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 80,
              width: 380,
              child: ListView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userinput,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
              width: 380,
              child: ListView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      result,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              color: Colors.grey[900],
              height: 370,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3 / 2,
                    crossAxisCount: 4,
                    mainAxisSpacing: 10),
                itemBuilder: (BuildContext context, int index) => CustomButton(
                  ButtonList[index],
                ),
                itemCount: ButtonList.length,
              ),
            ),
          ],
        )));
  }

  Widget CustomButton(String text) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          handlebuttons(text);
        });
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.grey[900],
        foregroundColor: buttoncolor[200],
        shape: const CircleBorder(),
      ),
      child: Text(text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: getColors(text),
          )),
    );
  }

  getColors(String text) {
    if (text == "C" ||
        text == "%" ||
        text == "÷" ||
        text == "x" ||
        text == "-" ||
        text == "+" ||
        text == "AC" ||
        text == "=") {
      return buttoncolor;
    }
    return Colors.white;
  }

  handlebuttons(String text) {
    if (text == "AC") {
      userinput = "";
      result = "";
      return;
    }
    if (text == "C") {
      if (userinput.isNotEmpty) {
        userinput = userinput.substring(0, userinput.length - 1);
        String lastString =
            userinput.substring(userinput.length - 1, userinput.length);
        if (lastString != "%" &&
            lastString != "÷" &&
            lastString != "x" &&
            lastString != "-" &&
            lastString != "+" &&
            lastString != "AC" &&
            lastString != "=") {
          equalPressed();
        }
        return;
      } else {
        return null;
      }
    }
    if (text == '=') {
      userinput = result;
      result = '';
    }
    if (text != '=') {
      userinput = userinput + text;
      String lastString =
          userinput.substring(userinput.length - 1, userinput.length);
      if (lastString != "C" &&
          lastString != "%" &&
          lastString != "÷" &&
          lastString != "x" &&
          lastString != "-" &&
          lastString != "+" &&
          lastString != "AC" &&
          lastString != "=") {
        equalPressed();
      }
    }
  }

  equalPressed() {
    String userInputFC = userinput;
    userInputFC = userInputFC.replaceAll("x", "*");
    userInputFC = userInputFC.replaceAll('÷', '/');

    Parser p = Parser();
    Expression exp = p.parse(userInputFC);
    ContextModel ctx = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, ctx);

    result = eval.toString().replaceAll(".0", "");
  }
}

const buttoncolor = Colors.amber;
