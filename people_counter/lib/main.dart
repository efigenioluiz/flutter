import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Account People',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _people = 0;
  String _msg="You may come in!";

  void _ChangePeople(int a) {
    setState(() {
      this._people += a;

      if(_people <0){
        _msg="Crazy Man!";
      }else if( _people <=10){
        _msg="You may come in";
      }
      else{
        _msg="It's Crowded!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/restaurant.jpg",
          fit: BoxFit.cover,
          height: 1000.0,
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text("People $_people",
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: FlatButton(
                child: Text("++",
                    style: TextStyle(fontSize: 40.0, color: Colors.white)),
                onPressed: () {
                  _ChangePeople(1);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: FlatButton(
                child: Text("--",
                    style: TextStyle(fontSize: 40.0, color: Colors.white)),
                onPressed: () {
                  _ChangePeople(-1);
                },
              ),
            ),
          ]),
          Text(_msg,
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 30.0)),
        ])
      ],
    );
  }
}
