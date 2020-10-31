import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const request = "https://api.hgbrasil.com/finance?key=865e2b6b";

void main() {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
        hintColor: Colors.amberAccent,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amberAccent)),
          hintStyle: TextStyle(color: Colors.amberAccent),
        )),
//    theme: ,
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final dolarController = TextEditingController();
  final realController = TextEditingController();
  final euroController = TextEditingController();

  double dolar;
  double euro;

  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  void _changedFieldDolar(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsPrecision(2);
  }

  void _changedFieldEuro(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsPrecision(2);
  }

  void _changedFieldReal(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsPrecision(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Coin Converter \$",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return msgScreen("Loading data ...");
            default:
              if (snapshot.hasError) {
                return msgScreen("Loading Error ...");
              } else {
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        size: 150.0,
                        color: Colors.amberAccent,
                      ),
                      fieldScreen(
                          "Real", "R", realController, _changedFieldReal),
                      Divider(),
                      fieldScreen(
                          "Dolar", "US", dolarController, _changedFieldDolar),
                      Divider(),
                      fieldScreen(
                          "Euro", "€", euroController, _changedFieldEuro),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

fieldScreen(String coin, String symbol, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
      labelText: "$coin",
      labelStyle: TextStyle(color: Colors.amberAccent),
      border: OutlineInputBorder(),
      prefixText: "$symbol\$",
    ),
    keyboardType: TextInputType.number,
    style: TextStyle(color: Colors.amberAccent, fontSize: 25.0),
    onChanged: f,
  );
}

msgScreen(String msg) {
  return Center(
    child: Text(
      msg,
      style: TextStyle(color: Colors.amberAccent, fontSize: 25.0),
      textAlign: TextAlign.center,
    ),
  );
}
