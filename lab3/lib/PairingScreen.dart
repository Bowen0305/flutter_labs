import 'dart:async';
import 'GlobalValues.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class PairingScreen extends StatefulWidget {
  PairingScreen({Key? key, required this.device}) : super(key: key);
  // 장치 정보 전달 받기
  final BluetoothDevice device;

  @override
  _PairingScreenState createState() => _PairingScreenState();
}

class _PairingScreenState extends State<PairingScreen> {
  // flutterBlue
  FlutterBlue flutterBlue = FlutterBlue.instance;

  // 연결 상태 표시 문자열
  String stateText = 'Connecting';

  // 연결 버튼 문자열
  String connectButtonText = 'Disconnect';

  // 현재 연결 상태 저장용
  BluetoothDeviceState deviceState = BluetoothDeviceState.disconnected;

  // 연결 상태 리스너 핸들 화면 종료시 리스너 해제를 위함
  StreamSubscription<BluetoothDeviceState>? _stateListener;

  List<BluetoothService> bluetoothService = [];
  List<BluetoothService> write_notify_Service = [];
  //
  Map<String, List<int>> notifyDatas = {};

  @override
  initState() {
    super.initState();
    // 상태 연결 리스너 등록
    _stateListener = widget.device.state.listen((event) {
      debugPrint('event :  $event');
      if (deviceState == event) {
        // 상태가 동일하다면 무시
        return;
      }
      // 연결 상태 정보 변경
      setBleConnectionState(event);
    });
    // 연결 시작
    connect();
  }

  BluetoothService _get_wn_service() {
    BluetoothService c = bluetoothService.firstWhere((s) =>
        s.uuid ==
        Guid(
            "9fa480e0-4967-4542-9390-d343dc5d04ae")); //8667556c-9a37-4c91-84ed-54ee27d90049    d0611e78-bbb4-4591-a5f8-487910ae4366
    return c;
  }

  @override
  Future<void> dispose() async {
    // 상태 리스터 해제
    _stateListener?.cancel();
    globalservice = _get_wn_service();
    globalcharacteristic = globalservice.characteristics
        .firstWhere((c) => c.properties.write && c.properties.notify);
    await globalcharacteristic.setNotifyValue(true);
    var a = globalcharacteristic.deviceId;
    globalcharacteristic.value.listen((value) {
      print('notification received: $value');
      if (value.length == 2) {
        globalvalue = value[0].toDouble();
        global_neg = value[1];
      }
      if (value.length == 1) {
        globalvalue = value[0].toDouble();
      }
      print('receive: $globalvalue , $global_neg');
      globalcharacteristic.setNotifyValue(true);
    });

    // 연결 해제
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      // 화면이 mounted 되었을때만 업데이트 되게 함
      super.setState(fn);
    }
  }

  /* 연결 상태 갱신 */
  setBleConnectionState(BluetoothDeviceState event) {
    switch (event) {
      case BluetoothDeviceState.disconnected:
        stateText = 'Disconnected';
        // 버튼 상태 변경
        connectButtonText = 'Connect';
        break;
      case BluetoothDeviceState.disconnecting:
        stateText = 'Disconnecting';
        break;
      case BluetoothDeviceState.connected:
        stateText = 'Connected';
        // 버튼 상태 변경
        connectButtonText = 'Disconnect';
        break;
      case BluetoothDeviceState.connecting:
        stateText = 'Connecting';
        break;
    }
    //이전 상태 이벤트 저장
    deviceState = event;
    setState(() {});
  }

  /* 연결 시작 */
  Future<bool> connect() async {
    Future<bool>? returnValue;
    setState(() {
      /* 상태 표시를 Connecting으로 변경 */
      stateText = 'Connecting';
    });

    /* 
      타임아웃을 15초(15000ms)로 설정 및 autoconnect 해제
       참고로 autoconnect가 true되어있으면 연결이 지연되는 경우가 있음.
     */
    await widget.device
        .connect(autoConnect: false)
        .timeout(Duration(milliseconds: 15000), onTimeout: () {
      //타임아웃 발생
      //returnValue를 false로 설정
      returnValue = Future.value(false);
      debugPrint('timeout failed');

      //연결 상태 disconnected로 변경
      setBleConnectionState(BluetoothDeviceState.disconnected);
    }).then((data) async {
      bluetoothService.clear();
      if (returnValue == null) {
        //returnValue가 null이면 timeout이 발생한 것이 아니므로 연결 성공
        debugPrint('connection successful');
        print('start discover service');
        List<BluetoothService> bleServices =
            await widget.device.discoverServices();
        setState(() {
          bluetoothService = bleServices;
        });
        // 각 속성을 디버그에 출력
        for (BluetoothService service in bleServices) {
          // print('============================================');
          // print('Service UUID: ${service.uuid}');
          for (BluetoothCharacteristic c in service.characteristics) {
            // print('\tcharacteristic UUID: ${c.uuid.toString()}');
            // print('\t\twrite: ${c.properties.write}');
            // print('\t\tread: ${c.properties.read}');
            // print('\t\tnotify: ${c.properties.notify}');
            // print('\t\tisNotifying: ${c.isNotifying}');
            // print(
            //     '\t\twriteWithoutResponse: ${c.properties.writeWithoutResponse}');
            // print('\t\tindicate: ${c.properties.indicate}');

            // notify나 indicate가 true면 디바이스에서 데이터를 보낼 수 있는 캐릭터리스틱이니 활성화 한다.
            // 단, descriptors가 비었다면 notify를 할 수 없으므로 패스!
            if (c.properties.notify && c.descriptors.isNotEmpty) {
              // 진짜 0x2902 가 있는지 단순 체크용!
              for (BluetoothDescriptor d in c.descriptors) {
                // print('BluetoothDescriptor uuid ${d.uuid}');
                if (d.uuid == BluetoothDescriptor.cccd) {
                  // print('d.lastValue: ${d.lastValue}');
                }
              }

              // notify가 설정 안되었다면...
              if (!c.isNotifying) {
                try {
                  await c.setNotifyValue(true);
                  // 받을 데이터 변수 Map 형식으로 키 생성
                  notifyDatas[c.uuid.toString()] = List.empty();
                  c.value.listen((value) {
                    // 데이터 읽기 처리!
                    // print('${c.uuid}: $value');
                    setState(() {
                      // 받은 데이터 저장 화면 표시용
                      notifyDatas[c.uuid.toString()] = value;
                    });
                  });

                  // 설정 후 일정시간 지연
                  await Future.delayed(const Duration(milliseconds: 500));
                } catch (e) {
                  // print('error ${c.uuid} $e');
                }
              }
            }
          }
        }
        returnValue = Future.value(true);
      }
    });

    return returnValue ?? Future.value(false);
  }

  /* 연결 해제 */
  void disconnect() {
    try {
      setState(() {
        stateText = 'Disconnecting';
      });
      widget.device.disconnect();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /* 장치명 */
        title: Text(widget.device.name),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              /* 연결 상태 */
              Text('$stateText'),
              /* 연결 및 해제 버튼 */
              OutlinedButton(
                  onPressed: () {
                    if (deviceState == BluetoothDeviceState.connected) {
                      disconnect();
                    } else if (deviceState ==
                        BluetoothDeviceState.disconnected) {
                      connect();
                    }
                  },
                  child: Text(connectButtonText)),
            ],
          ),
          Expanded(
            child: ListView.separated(
              itemCount: bluetoothService.length,
              itemBuilder: (context, index) {
                return listItem(bluetoothService[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            ),
          ),
        ],
      )),
    );
  }

  Widget characteristicInfo(BluetoothService r) {
    String name = '';
    String properties = '';
    String data = '';
    for (BluetoothCharacteristic c in r.characteristics) {
      properties = '';
      data = '';
      name += '\t\t${c.uuid}\n';
      if (c.properties.write) {
        properties += 'Write ';
      }
      if (c.properties.read) {
        properties += 'Read ';
      }
      if (c.properties.notify) {
        properties += 'Notify ';
        if (notifyDatas.containsKey(c.uuid.toString())) {
          if (notifyDatas[c.uuid.toString()]!.isNotEmpty) {
            data = notifyDatas[c.uuid.toString()].toString();
          }
        }
      }
      if (c.properties.writeWithoutResponse) {
        properties += 'WriteWR ';
      }
      if (c.properties.indicate) {
        properties += 'Indicate ';
      }
      name += '\t\t\tProperties: $properties\n';
      if (data.isNotEmpty) {
        name += '\t\t\t\t$data\n';
      }
      if (c.properties == 'Write Notiy ') {
        write_notify_Service.add(r);
      }
    }
    return Text(name);
  }

  Widget serviceUUID(BluetoothService r) {
    String name = '';
    name = r.uuid.toString();
    return Text(name);
  }

  Widget listItem(BluetoothService r) {
    return ListTile(
      onTap: null,
      title: serviceUUID(r),
      subtitle: characteristicInfo(r),
    );
  }
}
