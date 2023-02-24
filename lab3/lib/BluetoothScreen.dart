import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bluetooth/bluetooth.dart';

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  FlutterBlue _flutterBlue = FlutterBlue.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paired Device"),
      ),
      body: Column(
        children: [Text('localName: ')],
      ),
    );
  }
}
