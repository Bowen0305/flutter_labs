import 'package:flutter/material.dart';
import 'package:selectable_circle/selectable_circle.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab4',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Po-Ying Huang Lab4'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var rng = Random();
  int _pad = 5;
  int _ticks = 0;
  bool flag2 = false;
  bool flag = false;
  late Timer _timer;
  List<List> dots = List<List>.generate(
      3, (index) => List<bool>.generate(10, (index) => false));

  @override
  void _high() {
    if (!flag) {
      flag2 = true;
      flag = !flag;
      _timer = Timer.periodic(Duration(milliseconds: 100), (Timer t) {
        setState(() {
          dots[_counter ~/ 10][_counter % 10] =
              !dots[_counter ~/ 10][_counter % 10];
          _ticks--;
          if (_ticks <= 0) update();
        });
      });
    } else {
      flag2 = true;
    }
  }

  void _low() {
    flag2 = false;
  }

  void update() {
    _ticks = rng.nextInt(10) + _pad;
    if (flag2) {
      dots[_counter ~/ 10][_counter % 10] = true;
      if (_counter < 30) _counter += 1;
    } else {
      dots[_counter ~/ 10][_counter % 10] = false;
      if (_counter > 0) _counter -= 1;
      // for (int i = 0; i < _counter + 1; i++) dots[i ~/ 10][i % 10] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                dots[0].length,
                (index) {
                  return SelectableCircle(
                    width: 30.0,
                    isSelected: dots[0][index],
                    color: Colors.transparent,
                    selectedBorderColor: Colors.blue,
                    selectedColor: Colors.blue,
                    selectMode: SelectMode.simple,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                dots[0].length,
                (index) {
                  return SelectableCircle(
                    width: 30.0,
                    isSelected: dots[1][index],
                    color: Colors.transparent,
                    selectedBorderColor: Colors.blue,
                    selectedColor: Colors.blue,
                    selectMode: SelectMode.simple,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                dots[0].length,
                (index) {
                  return SelectableCircle(
                    width: 30.0,
                    isSelected: dots[2][index],
                    color: Colors.transparent,
                    selectedBorderColor: Colors.blue,
                    selectedColor: Colors.blue,
                    selectMode: SelectMode.simple,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _high,
                  child: const Text('Higher'),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                ElevatedButton(
                  onPressed: _low,
                  child: const Text('Lower'),
                ),
              ],
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
