import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  final FlutterBlue bluetooth = FlutterBlue.instance;
  Future<bool> checkBluetooth() async {
    return await bluetooth.isOn;
  }

  void getPairedDevices() async {
    List<BluetoothDevice> pairedDevices = [];
    final List<BluetoothDevice> devices = await bluetooth.connectedDevices;
    for (BluetoothDevice device in devices) {
      pairedDevices.add(device);
    }
    for (BluetoothDevice device in pairedDevices) {
      print('Name: ${device.name}, ID: ${device.id}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paired Device"),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: getPairedDevices, child: const Text('data'))
        ],
      ),
    );
  }
}
