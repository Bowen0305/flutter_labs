import 'package:flutter/material.dart';
import 'package:selectable_circle/selectable_circle.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';
import 'dart:io';
import 'dart:async';

class AcceleroScreen extends StatefulWidget {
  @override
  _AcceleroScreenState createState() => _AcceleroScreenState();
}

class _AcceleroScreenState extends State<AcceleroScreen> {
  @override
  List<bool> dots = [false, false, false, false, false, false, false];
  double x = 0, y = 0, z = 0;
  double total = 0, max = 0;
  late StreamSubscription<dynamic> _sensor;
  void initState() {
    _sensor = userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      x = event.x;
      y = event.y;
      z = event.z;
      total = sqrt(x * x + y * y + z * z);

      print(total);

      setState(() {});
      // sleep(const Duration(seconds: 1));
    });
    // super.initState();
  }

  @override
  void dispose() {
    _sensor.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accelero Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SelectableCircle(
                  width: 30.0,
                  isSelected: dots[0],
                  color: Colors.transparent,
                  selectedBorderColor: Colors.blue,
                  selectedColor: Colors.blue,
                  selectMode: SelectMode.simple,
                ),
                SelectableCircle(
                  width: 30.0,
                  isSelected: dots[1],
                  color: Colors.transparent,
                  selectedBorderColor: Colors.blue,
                  selectedColor: Colors.blue,
                  selectMode: SelectMode.simple,
                ),
                SelectableCircle(
                  width: 30.0,
                  isSelected: dots[2],
                  color: Colors.transparent,
                  selectedBorderColor: Colors.blue,
                  selectedColor: Colors.blue,
                  selectMode: SelectMode.simple,
                ),
                SelectableCircle(
                  width: 30.0,
                  isSelected: dots[3],
                  color: Colors.transparent,
                  selectedBorderColor: Colors.blue,
                  selectedColor: Colors.blue,
                  selectMode: SelectMode.simple,
                ),
                SelectableCircle(
                  width: 30.0,
                  isSelected: dots[4],
                  color: Colors.transparent,
                  selectedBorderColor: Colors.blue,
                  selectedColor: Colors.blue,
                  selectMode: SelectMode.simple,
                ),
                SelectableCircle(
                  width: 30.0,
                  isSelected: dots[5],
                  color: Colors.transparent,
                  selectedBorderColor: Colors.blue,
                  selectedColor: Colors.blue,
                  selectMode: SelectMode.simple,
                ),
                SelectableCircle(
                  width: 30.0,
                  isSelected: dots[6],
                  color: Colors.transparent,
                  selectedBorderColor: Colors.blue,
                  selectedColor: Colors.blue,
                  selectMode: SelectMode.simple,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
