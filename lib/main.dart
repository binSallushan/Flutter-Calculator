import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {    
    return MaterialApp(      
      title: "Calculator",
      theme: ThemeData(                
        textTheme: Typography.blackRedmond,                
        scaffoldBackgroundColor: Color.fromRGBO(6, 43, 44, 0.612),                
      ),
      home: Calculator()
    );
  }
}

class Calculator extends StatefulWidget{
 @override
  State<StatefulWidget> createState() => CalculatorState();
}
class CalculatorState extends State<Calculator> {
  var numberOne = 0;
  var numberTwo = 0;
  var operator = "";
  var result = "0";
  var calculated = false;

  void SetNumber(int num)
  {    
    if (calculated)
    {
      calculated = false;
      numberOne = 0;
      numberTwo = 0;
      operator = "";
      result = "0";
    }
    if (operator == "")
    {
      setState(() {
        //Appending num to numberOne
        numberOne = (numberOne * 10) + num;  
        result = numberOne.toString();
      });
      
    }
    else
    {      
      setState(() {
        //Appending num to numberTwo
        numberTwo = (numberTwo * 10) + num;
        result = "${numberOne.toString()}${operator}${numberTwo.toString()}";
      });
    }
  }

  void SetOperator(String op)  
  {
    setState(() {
      if (operator == "")
      {
        operator = op;
        result = "${numberOne.toString()}${operator}";  
      }
        
    });    
  }

  void Calculate()
  {
    if (result == "${numberOne.toString()}${operator}${numberTwo.toString()}")
    {
      setState(() {
        switch (operator) {
        case "+":
          result = (numberOne + numberTwo).toString();
          break;
        case "-":
          result = (numberOne - numberTwo).toString();
          break;
        case "*":
          result = (numberOne * numberTwo).toString();
          break;
        case "/":
          result = (numberOne / numberTwo).toString();
          break;
        default:        
        }

        calculated = true;
      });      
    }    
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(      
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(         
          mainAxisAlignment: MainAxisAlignment.end,                            
          children: [
            Text(result, style: const TextStyle(decoration: TextDecoration.none, color: Colors.black, fontSize: 50, fontWeight: FontWeight.normal),),            
            KeyPad(this)
          ],
        ),
      ),
    );
  }
}

class ButtonNumber extends StatelessWidget {
  final String text;
  final CalculatorState calc;
  const ButtonNumber(this.text, this.calc, {super.key});

  @override
  Widget build(BuildContext context) {    
    double size = 90;    

    return GestureDetector(
      onTap: () {calc.SetNumber(int.parse(text)); Feedback.forTap(context);},
      child: Container(      
        height: size,
        width: size,
        decoration: BoxDecoration (
          shape: BoxShape.circle,
          color: Color.fromRGBO(45, 72, 59, 90)
        ),
        child: Center(child: Text(text, style: const TextStyle(decoration: TextDecoration.none, color: Colors.black, fontSize: 30),)),
      ),
    );
  }
}

class KeyPadNumbers extends StatelessWidget {
  final CalculatorState calc;
  KeyPadNumbers(this.calc);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(           
          children: [
            Row(              
              //mainAxisAlignment: MainAxisAlignment.center,          
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0, left: 2, right: 5),
                  child: ButtonNumber("7", calc),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0, right: 5),
                  child: ButtonNumber("8", calc),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: ButtonNumber("9", calc),
                ),            
              ],
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.center,          
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0, left: 2, right: 5),
                  child: ButtonNumber("4", calc),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0, right: 5),
                  child: ButtonNumber("5", calc),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: ButtonNumber("6", calc),
                ),            
              ],          
            ),
            Row(          
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2, right: 5),
                  child: ButtonNumber("1", calc),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: ButtonNumber("2", calc),
                ),
                ButtonNumber("3", calc),            
              ]
              
            )
            
          ],
        );
  }
}

class KeyPadOperators extends StatelessWidget {
  const KeyPadOperators({
    super.key,
    required this.sizeHeight,
    required this.sizeWidth,
    required this.text,     
    required this.calc,
  });

  final double sizeHeight;
  final double sizeWidth;
  final String text;
  final CalculatorState calc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {calc.SetOperator(text); Feedback.forTap(context);},
      child: Container(
        height: sizeHeight,
        width: sizeWidth,
        decoration: BoxDecoration(
          color: Color.fromRGBO(60, 59, 69, 100),
          border: Border(bottom: BorderSide(width: 2), top: BorderSide(width: 2), left: BorderSide(width: 2), right: BorderSide(width: 2))
        ),
        child: Center(
          child: Text(text, style: const TextStyle(decoration: TextDecoration.none, color: Colors.black, fontWeight: FontWeight.normal, fontSize: 35)),
      )
      ),
    );
  }
}

class KeyPad extends StatelessWidget {
  const KeyPad(this.calc, {super.key});

  final CalculatorState calc;
  final sizeHeight = 90.0;
  final sizeWidth = 55.0;

  @override
  Widget build(BuildContext context) {    
    return Row(
      children: [
        KeyPadNumbers(calc),

        Column(          
          children: [
            Row(              
              children: [
                KeyPadOperators(sizeHeight: sizeHeight, sizeWidth: sizeWidth, text: "+", calc: calc,),
                KeyPadOperators(sizeHeight: sizeHeight, sizeWidth: sizeWidth, text: "-", calc: calc)
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  KeyPadOperators(sizeHeight: sizeHeight, sizeWidth: sizeWidth, text: "*", calc: calc),
                  KeyPadOperators(sizeHeight: sizeHeight, sizeWidth: sizeWidth, text: "/", calc: calc)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: GestureDetector(
                onTap: () {calc.Calculate(); Feedback.forTap(context);},
                child: Container(
                  width: 110,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(60, 59, 69, 100),
                    border: Border(bottom: BorderSide(width: 2), top: BorderSide(width: 2), left: BorderSide(width: 2), right: BorderSide(width: 2))
                  ),
                  child: Center(
                    child: Text("=", style: const TextStyle(decoration: TextDecoration.none, color: Colors.black, fontWeight: FontWeight.normal, fontSize: 35))),
                ),
              ),
            )          
          ]
          
        ),
      ],
    );
  }
}