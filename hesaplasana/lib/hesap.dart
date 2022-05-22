import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String denklem = "0";
  String sonuc = "0";
  String ifade = "";
  double denklemYaziBoyutu = 38.0;
  double sonucYaziBoyutu = 48.0;

  buttonPressed(String buttonText) {
    // tüm aritmetik mantıkları içerir
    setState(() {
      if (buttonText == "C") {
        denklem = "0";
        sonuc = "0";
        denklemYaziBoyutu = 38.0;
        sonucYaziBoyutu = 68.0;
      } else if (buttonText == "⌫") {
        denklemYaziBoyutu = 48.0;
        sonucYaziBoyutu = 68.0;
        denklem = denklem.substring(0, denklem.length - 1);
        if (denklem == "") {
          denklem = "0";
        }
      } else if (buttonText == "=") {
        denklemYaziBoyutu = 38.0;
        sonucYaziBoyutu = 68.0;

        ifade = denklem;
        ifade = ifade.replaceAll('×', '*');
        ifade = ifade.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(ifade);

          ContextModel cm = ContextModel();
          sonuc = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          sonuc = "HATA";
        }
      } else {
        denklemYaziBoyutu = 48.0;
        sonucYaziBoyutu = 38.0;
        if (denklem == "0") {
          denklem = buttonText;
        } else {
          denklem = denklem + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        child: Container(),
        onPressed: () => buttonPressed(buttonText),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          primary: Colors.white,
          textStyle: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Center(child: Text('Hesaplasana')),
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              denklem,
              style:
                  TextStyle(fontSize: denklemYaziBoyutu, color: Colors.white),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              sonuc,
              style: TextStyle(fontSize: sonucYaziBoyutu, color: Colors.white),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton(
                        "C",
                        1,
                        Colors.grey.shade900,
                      ),
                      buildButton("⌫", 1, Colors.grey.shade800),
                      buildButton("÷", 1, Colors.grey.shade800),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Colors.grey.shade400),
                      buildButton("9", 1, Colors.grey.shade400),
                      buildButton("8", 1, Colors.grey.shade400),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.grey.shade400),
                      buildButton("5", 1, Colors.grey.shade400),
                      buildButton("6", 1, Colors.grey.shade400),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Colors.grey.shade400),
                      buildButton("2", 1, Colors.grey.shade400),
                      buildButton("3", 1, Colors.grey.shade400),
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, Colors.grey.shade400),
                      buildButton("0", 1, Colors.grey.shade400),
                      buildButton("00", 1, Colors.grey.shade400),
                    ]),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("×", 1, Colors.grey.shade800),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.grey.shade800),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.grey.shade800),
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, Colors.grey.shade900),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
