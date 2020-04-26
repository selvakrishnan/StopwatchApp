import 'package:flutter/material.dart';
import 'dart:async';

class HomeWidget extends StatefulWidget {
  @override
  HomeWidgetState createState() => new HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {
  String _buttonText = "Start";
  String _zeros = "00:00:00";
  final _stopWatch = new Stopwatch();
  final _secondtocount = const Duration(seconds: 1);

  void _startTime() {
    new Timer(_secondtocount, _handle);
  }

  void _handle() {
    if (_stopWatch.isRunning) {
      _startTime();
    }
    setState(() {
      _countingprocess();
    });
  }
   void _startStopButton() {
    setState(() {
      if (_stopWatch.isRunning) {
        _buttonText = "Start";
        _stopWatch.stop();
      }
      else {
        _buttonText = "Stop";
        _stopWatch.start();
        _startTime();
      }
    });
  }

  void _resetButton() {
    if (_stopWatch.isRunning) {
      _startStopButton();
    }
    setState(() {
      _stopWatch.reset();
      _countingprocess();
    });
  }

  void _countingprocess() {
    _zeros = _stopWatch.elapsed.inHours.toString().padLeft(2, "0") + ":" +
                       (_stopWatch.elapsed.inMinutes%60).toString().padLeft(2, "0") + ":" +
                       (_stopWatch.elapsed.inSeconds%60).toString().padLeft(2, "0");
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
        title: Text("Stopwatch"),
      ),
      body: _userinterface(),
    );
  }

  Widget _userinterface() {
    return Column(
      children: <Widget>[
        
        Expanded(
          child: FittedBox(
            fit: BoxFit.none, 
            child: Text(_zeros,
              style: TextStyle(
                fontSize: 72,
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            padding: EdgeInsets.all(70),
            child:Column(
            children: <Widget>[
              FlatButton(
                color: Colors.blue,
                onPressed: _startStopButton,
                child: Text(_buttonText),textColor: Colors.white,
              ),
              FlatButton(
                color: Colors.blue,
                onPressed: _resetButton,
                child: Text("Reset"),textColor: Colors.white,
              ), 
            ], 
          ),)
        ),
      ],
    );
  }

}