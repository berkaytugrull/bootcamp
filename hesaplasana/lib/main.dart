import 'package:flutter/material.dart';
import 'hesap.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hesaplasana',
      theme: ThemeData(backgroundColor: Colors.black87),
      home: SimpleCalculator(),
    );
  }
}
