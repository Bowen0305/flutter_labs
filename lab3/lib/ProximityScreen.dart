import 'dart:async';
import 'package:flutter/material.dart';
import 'package:selectable_circle/selectable_circle.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'dart:io';
import 'package:wakelock/wakelock.dart';
import 'GlobalValues.dart';

class ProximityScreen extends StatefulWidget {
  @override
  _ProximityScreenState createState() => _ProximityScreenState();
}

class _ProximityScreenState extends State<ProximityScreen> {
  List<bool> dots = [false, false, false, false, false, false, false];

  int prev_event = 0;
  late StreamSubscription<dynamic> _sensor;
  @override
  void initState() {
    _sensor = ProximitySensor.events.listen((int event) async {
      if (event != prev_event) {
        prev_event = event;
        int i = 0;
        for (i = 0; i < 7; i++) {
          dots[i] = (event > 0) ? true : false;
        }

        setState(() {});
        await characteristic.write([event], withoutResponse: true);
      }

      if (globalvalue != 0) {
        for (int i = 0; i < 7; i++) {
          dots[i] = (globalvalue > 0) ? true : false;
        }
        setState(() {});
        globalvalue = 0;
      }

      // sleep(const Duration(seconds: 1));
    });

    super.initState();
  }

  @override
  void dispose() {
    _sensor.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Proximity Screen"),
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
