package com.example.info20512018;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothServerSocket;
import android.bluetooth.BluetoothSocket;

import java.io.IOException;
import java.lang.Thread;
import java.util.UUID;

class BluetoothAcceptThread extends Thread {
    private BluetoothHandler bHandler;
    private BluetoothAdapter bAdapter;
    private BluetoothServerSocket bServerSocket;

    public BluetoothAcceptThread(BluetoothHandler bHandler, 
                                 String name, UUID uuid) throws IOException {
        this.bHandler = bHandler;
        this.bAdapter = bHandler.getBluetoothAdapter();
        bServerSocket = bAdapter.listenUsingRfcommWithServiceRecord(name, uuid);
    }
    
    public void run() {
        // check that the server socket was created
        if(bServerSocket == null)
            return;
        // listen for a connection
        BluetoothSocket bSocket = null;
        while (true) {
            try {
                bSocket = bServerSocket.accept();
            }
            catch (IOException e) {
                e.printStackTrace();
                break;
            }
            // check successful connection
            if (bSocket != null) {
                try {
                    bHandler.setBluetoothSocket(bSocket);
                    bServerSocket.close();
                }
                catch (IOException e) {
                    e.printStackTrace();
                }
                break;
            }
        }
    }
    
    public void cancel() {
        try {
            bServerSocket.close();
        }
        catch (IOException e) {
            bServerSocket = null;
        }
    }
}
