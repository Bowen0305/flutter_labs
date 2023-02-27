import 'package:flutter/material.dart';
import 'package:selectable_circle/selectable_circle.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';
import 'dart:io';
import 'dart:async';
import 'GlobalValues.dart';

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
    int i = 0;
    int time1 = 0;
    int time2 = 0;
    List<double> value = [30, 50, 70, 20];
    final Stream timer1 = Stream.periodic(Duration(milliseconds: 200), (_) {});
    timerr = timer1.listen((event) {
      if (time1 > 2000)
        time2 += 200;
      else
        time1 += 200;

      if (time2 % 1000 == 0 && time1 > 20000) {
        print(time2.toString());
        globalvalue = value[0];
        i += 1;
        if (i > 3) i = 3;
      }

      if (globalvalue != 0) {
        int i = 0;
        for (i = 0; i < 7; i++) {
          dots[i] = globalvalue > 10 + i * 10;
        }
        globalvalue = 0;
        setState(() {});
      }
    });
    // _sensor =
    //     userAccelerometerEvents.listen((UserAccelerometerEvent event) async {
    //   x = event.x;
    //   y = event.y;
    //   z = event.z;
    //   total = sqrt(x * x + y * y + z * z);

    //   if (total > 10) {
    //     if (total > max) max = total;
    //   }

    //   if (total < 5 && max != 0) {
    //     int i = 0;
    //     for (i = 0; i < 7; i++) {
    //       dots[i] = max > 10 + i * 10;
    //     }

    //     setState(() {});
    //     await write([total.round()]);
    //     max = 0;
    //   }

    // sleep(const Duration(seconds: 1));
    // });

    // super.initState();
  }

  @override
  void dispose() {
    // _sensor.cancel();
    timerr.cancel();
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
