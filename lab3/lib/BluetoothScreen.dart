import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  FlutterBlue _flutterBlue = FlutterBlue.instance;
  void _check() {
    print(_flutterBlue.connectedDevices);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paired Device"),
      ),
      body: Column(
        children: [Text('localName: $_flutterBlue.connectedDevices')],
      ),
    );
  }
}