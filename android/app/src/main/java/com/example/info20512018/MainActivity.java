package com.example.info20512018;

import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import java.io.IOException;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "bluetooth";
  private static BluetoothHandler bluetoothHandler;

  @Override
  public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    try {
      bluetoothHandler = new BluetoothHandler();
    }
    catch(IOException e) {
      e.printStackTrace();
      bluetoothHandler = null;
    }

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
      new MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall call, Result result) {
          if(bluetoothHandler == null)
            result.error("UNAVAILABLE", "Bluetooth not available.", null);
          else {
            switch(call.method) {
              case "getPairedNames":
                result.success(bluetoothHandler.getPairedNames());
                break;

              case "isEnabled":
                result.success(bluetoothHandler.isEnabled());
                break;

              case "connectToPaired":
                result.success(bluetoothHandler.connectToPaired(call.argument("deviceName")));
                break;

              case "waitConnection":
                result.success(bluetoothHandler.waitConnection());
                break;

              case "isConnected":
                result.success(bluetoothHandler.isConnected());
                break;

              case "disconnect":
                result.success(bluetoothHandler.disconnect());
                break;

              case "write":
                result.success(bluetoothHandler.write(call.argument("data")));
                break;

              case "read":
                result.success(bluetoothHandler.read(call.argument("nb")));
                break;
              
              default:
                result.notImplemented();
                break;
            }
          }
        }
      }
    );
  }
}
