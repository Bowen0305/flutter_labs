import 'package:flutter_blue/flutter_blue.dart';

double globalvalue = 0;
late BluetoothCharacteristic globalcharacteristic;
late BluetoothService globalservice;
Future<void> write(List<int> value) async {
  for (BluetoothCharacteristic c in globalservice.characteristics) {
    await c.write(value, withoutResponse: true);
  }
}

int global_neg = 0;
