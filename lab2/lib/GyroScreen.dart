import 'dart:async';
import 'package:flutter/material.dart';
import 'package:selectable_circle/selectable_circle.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';
import 'dart:io';

class GyroScreen extends StatefulWidget {
  @override
  _GyroScreenState createState() => _GyroScreenState();
}

class _GyroScreenState extends State<GyroScreen> {
  @override
  List<bool> dots = [false, false, false, true, false, false, false];
  late StreamSubscription<dynamic> _sensor;
  double x = 0, y = 0, z = 0;
  void initState() {
    _sensor = gyroscopeEvents.listen((GyroscopeEvent event) {
      x = event.x;
      y = event.y;
      z = event.z;

      if (z.abs() > 2) {
        int i = 0;
        for (i = 0; i < 7; i++) {
          if (i < 3) dots[i] = z < (i - 3) * 2;
          if (i > 3) dots[i] = z > (i - 3) * 2;
        }
      }

      setState(() {});
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
        title: const Text("Gyro Screen"),
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
