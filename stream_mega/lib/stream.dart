import 'dart:async';
import 'package:flutter/material.dart';


class ColorStream{
  final List<Color> colors =[
    Colors.blueGrey,
    Colors.amber,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.teal,
    Colors.green,
    Colors.pinkAccent,
    Colors.brown,
    Colors.deepOrange,
    Colors.redAccent
  ];



  Stream<Color> getColors() async* {
    yield* Stream.periodic(
      const Duration(seconds: 1), (int t){
        int index = t % colors.length;
        return colors[index];
      },
    );
  }
}

class NumberStream{
  final StreamController<int> controller = StreamController<int>();

  void addNumberToSink(int newNumber){
    controller.sink.add(newNumber);
  }

  close(){
    controller.close();
  }

  addEror(){
    controller.sink.addError('error');
  }


}

