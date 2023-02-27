import 'package:flutter_blue/flutter_blue.dart';
import 'dart:async';

double globalvalue = 0;
late BluetoothCharacteristic globalcharacteristic;
late BluetoothService globalservice;
Future<void> write(List<int> value) async {
  for (BluetoothCharacteristic c in globalservice.characteristics) {
    await c.write(value, withoutResponse: true);
  }
}

int global_neg = 0;
bool timerflag = false;

late StreamSubscription<dynamic> timerr;
void timer() {
  int i = 0;
  int time1 = 0;
  int time2 = 0;
  List<double> value = [30, 50, 70, 20];
  final Stream timer1 = Stream.periodic(Duration(milliseconds: 20), (_) {});
  timerr = timer1.listen((event) {
    if (time1 > 200)
      time2 += 20;
    else
      time1 += 20;

    if (time2 % 100 == 0) globalvalue = value[i];
  });
}
