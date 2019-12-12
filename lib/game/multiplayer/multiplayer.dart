import 'dart:async';
import 'package:smashlike/game/multiplayer/bluetooth.dart';

class Multiplayer {
  static const int START = 1;
  static const int END = 2;
  static const int NONE = 3;
  static const int LEFT_START = 4;
  static const int LEFT_END = 5;
  static const int RIGHT_START = 6;
  static const int RIGHT_END = 7;
  static const int UP = 8;
  static const int A = 9;
  static const int LONG_A = 10;
  static const int B_START = 11;
  static const int B_END = 12;
  static const int FIREBALL = 13;

  Bluetooth bluetooth = Bluetooth();
  
  bool _isServer = false;
  int mapId = 0, firstPlayerId = 0;

  static final Multiplayer _inst = Multiplayer._internal();
  Multiplayer._internal();

  Future<bool> get isConnected {
    return bluetooth.isConnected;
  }

  factory Multiplayer() {
    return _inst;
  }

  Future<bool> host() {
    _isServer = true;
    return bluetooth.waitConnection();
  }

  Future<List<String>> getServers() {
    return bluetooth.pairedNames;
  }

  Future<bool> join(String deviceName) {
    _isServer = false;
    return bluetooth.connectToPaired(deviceName);
  }

  Future<bool> disconnect() {
    return bluetooth.disconnect();
  }

  Future<void> start() async {
    if(_isServer) {
      await bluetooth.write(mapId);
      await bluetooth.write(firstPlayerId);
    }
    else {
      mapId = await bluetooth.read();
      firstPlayerId = await bluetooth.read();
    }
  }

  Future<bool> send(int value) {
    return bluetooth.write(value);
  }

  Future<int> receive() {
    return bluetooth.read();
  }
}
