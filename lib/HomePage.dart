import 'package:flutter/material.dart';
import 'package:calculator_app/Buttons.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';

  final List<String> Button = [
    'C',
    "DEL",
    '%',
    '/',
    '9',
    "8",
    '7',
    'x',
    '6',
    "5",
    '4',
    '-',
    '3',
    "2",
    '1',
    '+',
    '0',
    ".",
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userQuestion,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userAnswer,
                    style: TextStyle(fontSize: 20),
                ),
                )
              ]    
            ),
          )),
          Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                    itemCount: Button.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return MyButton(
                             buttonTapped: (){
                            setState(() {
                            userQuestion = '';
                            userAnswer='';
                              
                            });
                          },
                            buttonText: Button[index],
                            color: Colors.green,
                            textColor: Colors.white);
                      } 
                      else if (index == 1) {
                        return MyButton(
                             buttonTapped: (){
                            setState(() {
                            userQuestion = userQuestion.substring(0,userQuestion.length-1);
                              
                            });
                          },
                          buttonText: Button[index],
                          color: Colors.red,
                          textColor: Colors.white,
                        );
                      } 
                        else if (index == Button.length-1) {
                        return MyButton(
                             buttonTapped: (){
                            setState(() {
                            equalPressed();
                              
                            });
                          },
                          buttonText: Button[index],
                          color: Colors.red,
                          textColor: Colors.white,
                        );
                      } 
                      else {
                        return MyButton(
                          buttonTapped: (){
                            setState(() {
                            userQuestion += Button[index];
                              
                            });
                          },
                          buttonText: Button[index],
                          color: isOperator(Button[index])
                              ? Colors.deepPurple
                              : Colors.deepPurple[50],
                          textColor: isOperator(Button[index])
                              ? Colors.white
                              : Colors.deepPurple,
                        );
                      }
                    }),
              ))
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }
  void equalPressed(){
    String finalQuestion=userQuestion;
    finalQuestion=finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer=eval.toString();
  }
}
