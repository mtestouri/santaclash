package com.example.info20512018;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.bluetooth.BluetoothServerSocket;

import java.io.IOException;
import java.io.OutputStream;
import java.io.InputStream;
import java.util.Set;
import java.util.UUID;
import java.util.List;
import java.util.ArrayList;
import java.io.DataOutputStream;
import java.io.DataInputStream;

/**
 * Class used to handle the Bluetooth adapter
 */
class BluetoothHandler {
    private static final UUID MY_UUID = UUID.fromString("7b2c86c3-a4d0-44ea-b3b2-5264c4784b7c");
    private static final String NAME = "SmashLike-Server";
    
    private BluetoothAdapter bAdapter;
    private BluetoothSocket bSocket;
    private DataOutputStream outputStream;
    private DataInputStream inputStream;
    private BluetoothAcceptThread bAccept;

    /**
     * Constructor of the class
     * @throws IOException Exception if Bluetooth is not supported by the device
     */
    BluetoothHandler() throws IOException {
        // check the presence of a bluetooth adapter
        bAdapter = BluetoothAdapter.getDefaultAdapter();
        if(bAdapter == null) {
            throw new IOException("No Bluetooth support");
        }
    }

    /**
     * Get the Bluetooth adapter associated with this handler
     * @return the Bluetooth adapter
     */
    BluetoothAdapter getBluetoothAdapter() {
        return bAdapter;
    }

    /**
     * Check if the Bluetooth adapter is enabled
     * @return true if enabled, false otherwise
     */
    boolean isEnabled() {
        return bAdapter.isEnabled();
    }

    /**
     * Return the paired devices names
     * @return a string array with the paired devices names
     */
    List<String> getPairedNames() {
        Set<BluetoothDevice> pairedDevices = bAdapter.getBondedDevices();
        List<String> pn = new ArrayList<>();
        
        if(!pairedDevices.isEmpty()) {
            for(BluetoothDevice device : pairedDevices)
                pn.add(device.getName() + "\n");
        }
        return pn;
    }

    /**
     * Connect to a selected paired device
     * @param deviceIndex the index of the device
     * @return true if the connection is successful, false otherwise
     */
    boolean connectToPaired(String deviceName) {
        reset();
        Set<BluetoothDevice> bondedDevices = bAdapter.getBondedDevices();
        if(!bondedDevices.isEmpty()) {
            for(BluetoothDevice device : bondedDevices) {
                if(device.getName().equals(deviceName)) {
                    try {
                        setBluetoothSocket(device.createRfcommSocketToServiceRecord(MY_UUID));
                        bSocket.connect();
                        break;
                    }
                    catch(IOException e) {
                        try {
                            e.printStackTrace();
                            bSocket.close();
                            return false;
                        }
                        catch(IOException e1) {
                            e1.printStackTrace();
                            return false;
                        }
                    }
                }
            }
        }
        return isConnected();
    }

    /**
     * Wait for a Bluetooth connection
     */
    boolean waitConnection() {
        reset();
        // create and run the accepting thread
        try {
            bAccept = new BluetoothAcceptThread(this, NAME, MY_UUID);
            bAccept.start();
            return true;
        }
        catch(IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Set the Bluetooth socket
     * @param bSocket the new Bluetooth socket
     */
    synchronized void setBluetoothSocket(BluetoothSocket bSocket) {
        try {
            if(this.bSocket != null)    
                this.bSocket.close();
            this.bSocket = bSocket;
            this.outputStream = new DataOutputStream(bSocket.getOutputStream());
            this.inputStream = new DataInputStream(bSocket.getInputStream());
        }
        catch(IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * Check if the adapter is connected
     * @return true if connected, false otherwise
     */
    boolean isConnected() {
        return ((bSocket != null) && bSocket.isConnected());
    }

    /**
     * Disconnect the adapter
     * @return true if successfully disconnected, false otherwise
     */
    boolean disconnect() {
        if(bSocket == null)
            return true;
        try {
            bSocket.close();
            reset();
            return true;
        }
        catch(IOException e) {
            e.printStackTrace();
            reset();
            return false;
        }
    }

    /**
     * Write data
     */
    boolean write(List<Double> data) {
        if(outputStream == null)
            return false;
        try {
            for(int i=0; i < data.size(); i++)
                outputStream.writeDouble(data.get(i));
            return true;
        }
        catch(IOException e) {
            try {
                bSocket.close();
            }
            catch(IOException e1) {
                bSocket = null;
            }
            return false;
        }
    }

    /**
     * Read data
     */
    List<Double> read(int nb) {
        List<Double> values = new ArrayList<>();
        // check existing input stream
        if(inputStream == null) {
            values.add(-1.);
            return values;
        }
        // check connection
        if(isConnected() == false) {
            values.add(-1.);
            return values;
        }
        // read data
        try {
            for(int i=0; i < nb; i++)
                values.add(inputStream.readDouble());
            return values;
        }
        catch(IOException e) {
            try {
                bSocket.close();
            }
            catch(IOException e1) {
                bSocket = null;
            }
            values.add(-1.);
            return values;
        }
    }

    /**
     * Reset the handler
     */
    void reset() {
        try {
            if(bSocket != null)
                bSocket.close();
        }
        catch(IOException e) {
            //e.printStackTrace();
        }
        try {
            if(outputStream != null)
                outputStream.close();
        }
        catch(IOException e) {
            //e.printStackTrace();
        }
        try {
            if(inputStream != null)
                inputStream.close();
        }
        catch(IOException e) {
            //e.printStackTrace();
        }
        if(bAccept != null)
            bAccept.cancel();
    }
}