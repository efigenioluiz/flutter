import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
    ),
  );
}



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _txtInfo = "Enter your data";

  void _refresh() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _txtInfo = "Enter your data";
    });
  }

  void _calculate() {
    setState(() {
      double weigth = double.parse(weightController.text);
      double heigth = double.parse(heightController.text) / 100;
      double imc = weigth / (heigth * heigth);
      if (imc < 18.6) {
        _txtInfo = "below of weight ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 18.6 && imc <= 24.9) {
        _txtInfo = "ideal  weight ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 24.9 && imc <= 29.9) {
        _txtInfo = "slightly overweight ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 29.9 && imc <= 34.9) {
        _txtInfo = "Grade I Obesity ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 34.9 && imc <= 39.9) {
        _txtInfo = "Grade II Obesity ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 40) {
        _txtInfo = "Grade III Obesity ${imc.toStringAsPrecision(4)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator IMC"),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _refresh();
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(Icons.person_outline, size: 120.0, color: Colors.green),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Weight (KG)",
                labelStyle: TextStyle(color: Colors.green),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 25.0),
              controller: weightController,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Height (CM)",
                labelStyle: TextStyle(color: Colors.green),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 25.0),
              controller: heightController,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Container(
                height: 50.0,
                child: RaisedButton(
                  child: Text(
                    "Calculate",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                  color: Colors.green,
                  onPressed: _calculate,
                ),
              ),
            ),
            Text(
              _txtInfo,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 25.0),
            ),
          ],
        ),
      ),
    );
  }
}
