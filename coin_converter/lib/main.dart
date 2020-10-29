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

  changedFieldDolar(){
//    print();
  }
  changedFieldEuro(){}
  changedFieldReal(){}

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
        builder: (contex, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return msgScreen("Loading data ...");
            default:
              if (snapshot.hasError) {
                return msgScreen("Loading Error ...");
              } else {
                dolar = snapshot.data["results"]["currencies"]["USD"];
                euro = snapshot.data["results"]["currencies"]["EUR"];
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
                      fieldScreen("Real", "R", realController, changedFieldReal()),
                      Divider(),
                      fieldScreen("Dolar", "US", dolarController, changedFieldDolar()),
                      Divider(),
                      fieldScreen("Euro", "€", euroController, changedFieldEuro()),
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
    decoration: InputDecoration(
      labelText: "$coin",
      labelStyle: TextStyle(color: Colors.amberAccent),
      border: OutlineInputBorder(),
      prefixText: "$symbol\$",
    ),
    keyboardType: TextInputType.number,
    style: TextStyle(color: Colors.amberAccent, fontSize: 25.0),
    controller: c,
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
