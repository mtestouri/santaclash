import 'dart:async';
import 'package:smashlike/game/multiplayer/bluetooth.dart';

class Multiplayer {
  Bluetooth bluetooth = Bluetooth();

  static final Multiplayer _inst = Multiplayer._internal();
  Multiplayer._internal();

  factory Multiplayer() {
    return _inst;
  }

  Future<bool> host() {
    return bluetooth.waitConnection();
  }

  Future<List<String>> getServers() {
    return bluetooth.pairedNames;
  }

  Future<bool> join(String deviceName) {
    return bluetooth.connectToPaired(deviceName);
  }

  Future<bool> isReady() {
    return bluetooth.isConnected;
  }

  List<int> _readPacket() {
    // TODO complete
    return bluetooth.read();
  }

  void _writePacket() {
    // TODO implement
    bluetooth.write([0]);
  }
}
