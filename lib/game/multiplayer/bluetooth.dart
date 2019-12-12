import 'dart:async';
import 'package:flutter/services.dart';

class Bluetooth {
  static const platform = const MethodChannel('bluetooth');

  static final Bluetooth _inst = Bluetooth._internal();
  Bluetooth._internal();

  Future<List<String>> get pairedNames async {
    List<String> pn = List();
    for(var name in await platform.invokeMethod('getPairedNames'))
      pn.add(name);
    return pn;
  }

  Future<bool> get isConnected {
    return platform.invokeMethod('isConnected');
  }

  factory Bluetooth() {
    return _inst;
  }

  Future<bool> isEnabled() {
    return platform.invokeMethod('isEnabled');
  }

  Future<bool> connectToPaired(String deviceName) {
    return platform.invokeMethod('connectToPaired', <String, dynamic>{
        'deviceName': deviceName
    });
  }

  Future<bool> waitConnection() {
    return platform.invokeMethod('waitConnection');
  }

  Future<bool> disconnect() {
    return platform.invokeMethod('disconnect');
  }

  Future<List<int>> read(int nb) {
    return platform.invokeMethod('read', <String, dynamic>{
        'nb': nb
    });
  }

  Future<bool> write(List<int> data) {
    return platform.invokeMethod('write', <String, dynamic>{
        'data': data
    });
  }
}
