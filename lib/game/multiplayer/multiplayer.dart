import 'package:flutter/material.dart';
import 'package:smashlike/game/multiplayer/bluetooth.dart';

/*class Multiplayer {
  Bluetooth bluetooth = Bluetooth();

  List<int> readPacket() {
    // implement
    return [0];
  }

  void writePackt() {
    // implement
  }
}*/

class Test extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TestState();
}

class TestState extends State<Test> {
  String text = 'Not connected';
  Bluetooth bluetooth = Bluetooth();
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Test'),
      ),
      body: Center(
        child: Text(text)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          text = 'Not connected';
          bluetooth.waitConnection();
          text = 'Waiting connection';
          setState(() {});
        },
        child: const Icon(Icons.bluetooth_searching),
      ),
    );
  }
}