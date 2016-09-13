react-native-sensor
============================

Wrapper for react-native. Accelerometer, Gyroscope, Magnetometer, (Step Counter, Thermometer) are supported for now.

Add it to your project
-------------------------

`$ npm i react-native-sensor --save`

### Option: With [`rnpm`](https://github.com/rnpm/rnpm)

`rnpm link`

### Option: Manually

Make alterations to the following files:

* `android/settings.gradle`

```gradle
...
include ':react-native-sensor'
project(':react-native-sensor').projectDir = new File(settingsDir, '../node_modules/react-native-sensor-manager/android')
```

* `android/app/build.gradle`

```gradle
...
dependencies {
    ...
    compile project(':react-native-sensor')
}
```

* register module (in MainActivity.java)

  * For react-native 0.19.0 and higher
```java
import com.sensormanager.SensorManagerPackage; // <------ add package

public class MainActivity extends ReactActivity {
   // ...
    @Override
    protected List<ReactPackage> getPackages() {
      return Arrays.<ReactPackage>asList(
        new MainReactPackage(), // <---- add comma
        new SensorManagerPackage() // <---------- add package
      );
    }
```

Api
----

### Setup
```js
import React, {
  DeviceEventEmitter // will emit events that you can listen to
} from 'react-native';

var mSensorManager = require('NativeModules').SensorManager;
```


### Accelerometer
```js
mSensorManager.startAccelerometer(100); // To start the accelerometer with a minimum delay of 100ms between events.
DeviceEventEmitter.addListener('Accelerometer', function (data) {
  /**
  * data.x
  * data.y
  * data.z
  **/
});
mSensorManager.stopAccelerometer();
```

### Gyroscope
```js
DeviceEventEmitter.addListener('Gyroscope', function (data) {
  /**
  * data.x
  * data.y
  * data.z
  **/
});
mSensorManager.startGyroscope(100);
mSensorManager.stopGyroscope();
```

### Magnetometer
```js
mSensorManager.startMagnetometer(100);
DeviceEventEmitter.addListener('Magnetometer', function (data) {
  /**
  * data.x
  * data.y
  * data.z
  **/
});
mSensorManager.stopMagnetometer();
```

### Step Counter
```js
mSensorManager.startStepCounter(1000);
DeviceEventEmitter.addListener('StepCounter', function (data) {
  /**
  * data.steps
  **/
});
mSensorManager.stopStepCounter();
```

### Thermometer
```js
mSensorManager.startThermometer(1000);
DeviceEventEmitter.addListener('Thermometer', function (data) {
  /**
  * data.temp
  **/
});
mSensorManager.stopThermometer();
```

### LightSensor
```js
mSensorManager.startLightSensor(100);
DeviceEventEmitter.addListener('LightSensor', function (data) {
  /**
  * data.light
  **/
});
mSensorManager.stopLightSensor();
```


### Proximity Sensor
```js
mSensorManager.startProximity(100);
DeviceEventEmitter.addListener('Proximity', function (data) {
  /**
  * data.isNear: [Boolean] A flag representing whether something is near the screen.
  * data.value: [Number] The raw value returned by the sensor (usually distance in cm).
  * data.maxRange: [Number] The maximum range of the sensor.
  **/
});
mSensorManager.stopProximity();
```
