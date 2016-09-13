//ios
import {Platform,NativeModules} from 'react-native'
var { Accelerometer, Gyroscope, Magnetometer } = NativeModules;

var isAndroid = Platform.OS === 'android'

//module.exports = class SensorManager {}
if(isAndroid) export.module = NativeModules.SensorManager
else export default class SensorManager {
    startAccelerometer(ms,callback){  // data.acceleration.(x,y,z)
        DeviceEventEmitter.addListener('Accelerometer', callback);
        Accelerometer.startAccelerometerUpdates(ms);
    }
    stopAccelerometer(){
        Accelerometer.stopAccelerometerUpdates();
    }

    startGyroscope(ms,callback){      // data.rotationRate.(x,y,z)
        DeviceEventEmitter.addListener('Gyroscope', callback);
        Gyroscope.startGyroUpdates(ms);
    }
    stopGyroscope(){
        Gyroscope.stopGyroUpdates();
    }

    startMagnetometer(ms,callback){   // data.magneticField.(x,y,z)
        DeviceEventEmitter.addListener('Magnetometer', callback);
        Magnetometer.startMagnetometerUpdates(ms);
    }
    stopMagnetometer(){
        Magnetometer.stopMagnetometerUpdates();
    }
}
