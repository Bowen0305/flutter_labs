import 'dart:async';
import 'package:flutter/material.dart';
import 'package:selectable_circle/selectable_circle.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';
import 'dart:io';
import 'GlobalValues.dart';

class GyroScreen extends StatefulWidget {
  @override
  _GyroScreenState createState() => _GyroScreenState();
}

class _GyroScreenState extends State<GyroScreen> {
  @override
  List<bool> dots = [false, false, false, true, false, false, false];
  late StreamSubscription<dynamic> _sensor;
  double x = 0, y = 0, z = 0;
  double max = 0;
  List<double> c = [7.0, 10.0, -7.0];
  int c2 = 0;
  void initState() {
    _sensor = gyroscopeEvents.listen((GyroscopeEvent event) {
      x = event.x;
      y = event.y;
      z = c[c2];
      sleep(const Duration(seconds: 1));
      c2 += 1;
      if (z.abs() > 5) {
        if (z > 0) {
          if (z > max) max = z;
        } else {
          if (z < max) max = z;
        }
      }

      if (z.abs() < 1 && max != 0) {
        int i = 0;
        for (i = 0; i < 7; i++) {
          if (i < 3) dots[i] = max < (i - 3) * 2 - 5;
          if (i > 3) dots[i] = max > (i - 3) * 2 + 5;
        }

        setState(() {});
        if (max > 0)
          globalcharacteristic.write([max.round(), 0], withoutResponse: true);
        else
          globalcharacteristic.write([max.round(), 1], withoutResponse: true);
        max = 0;
      }

      if (globalvalue != 0) {
        int i = 0;
        if (global_neg == 1) globalvalue = globalvalue * -1;

        for (i = 0; i < 7; i++) {
          if (i < 3) dots[i] = globalvalue < (i - 3) * 2 - 5;
          if (i > 3) dots[i] = globalvalue > (i - 3) * 2 + 5;
        }
        setState(() {});
        globalvalue = 0;
      }
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
                  isSelected: dots[6],
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
                  isSelected: dots[4],
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
                  isSelected: dots[2],
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
                  isSelected: dots[0],
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
