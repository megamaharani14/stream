import 'package:flutter/material.dart';
import 'stream.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Mega ',
      theme: ThemeData(
       primarySwatch: Colors.blueGrey,
      ),
      home: const StreamHomePage(),
    );
  }
}

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({super.key});

  @override
  State<StreamHomePage> createState() => _StreamHomePage();
}


class _StreamHomePage extends State<StreamHomePage> {
 Color bgColor = Colors.blueGrey;
  late ColorStream colorStream;

  // void changeColor() async{
  //   await for (var eventColor in ColorStream.getColors()) {
  //     setState(() {
  //       bgColor = eventColor;
  //     });
  //   }
  // }

  int lastNumber = 0;
  late StreamController numberStreamController;
  late NumberStream numberStream;

  late StreamTransformer transformer;
  late StreamSubscription subscription;

  late StreamSubscription subscription2;
  String values = '';

  @override
  void initState(){
    numberStream = NumberStream();
    numberStreamController = numberStream.controller;
    Stream stream = numberStreamController.stream.asBroadcastStream();
    subscription = stream.listen((event){
      setState(() {
        values += '$event - ';
        // lastNumber = event;
      });
    });
    subscription2 = stream.listen((event){
      setState(() {
        values += '$event - ';
      });
    });

    super.initState();

    subscription.onError((error){
      setState(() {
        lastNumber = -1;
      });
    });

    subscription.onDone((){
      print('OnDone was called');
    });
  }

  void stopStream(){
    numberStreamController.close();
  }

  //   transformer = StreamTransformer<int, int>.fromHandlers(
  //     handleData: (value, sink){
  //       sink.add(value * 10);
  //   },
  //   handleError: (error, trace, sink){
  //     sink.add(-1);
  //   },
  //   handleDone: (sink) => sink.close()
  //   ); 
    
  //   stream.transform(transformer).listen((event){
  //     setState(() {
  //       lastNumber = event;
  //     });
  //   }).onError((error){
  //     setState(() {
  //       lastNumber = -1;
  //     });
  //   });
  //   super.initState();
  // }
    // numberStream = NumberStream();
    // numberStreamController = numberStream.controller;
    // Stream stream = numberStreamController.stream;
    // stream.listen((event){
    //   setState(() {
    //     lastNumber = event;
    //   });
    // }).onError((error){
    //   setState(() {
    //     lastNumber = -1;
    //   });
    // });
   
  
    // super.initState();
    // colorStream = ColorStream();
    // // changeColor();
    // colorStream.getColors().listen((eventColor){
    //   setState(() {
    //     bgColor = eventColor;
    //   });
    // });
  

  @override
    void dispose(){
      numberStreamController.close();
      super.dispose();
      subscription.cancel();
    }
  
  void addRandomNumber(){
    Random random = Random();
    int myNum = random.nextInt(10);
    if (!numberStreamController.isClosed){
      numberStream.addNumberToSink(myNum);
    } else{
      setState(() {
        lastNumber = -1;
      });
    }
   
    // numberStream.addEror();
  }

 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(values),
            Text(lastNumber.toString()),
            ElevatedButton(
              onPressed: () => addRandomNumber(),
              child: Text('New Random Number'),
            ),
            ElevatedButton(
              onPressed: stopStream,
              child: const Text('Stop Subscription'),
            )
          ],
        ),
     )
    );
  }
}
