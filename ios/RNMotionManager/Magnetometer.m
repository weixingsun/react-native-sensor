//
//  Magnetometer.m
//
//  Created by Patrick Williams in beautiful Seattle, WA.
//

#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#import "Magnetometer.h"

@implementation Magnetometer

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

- (id) init {
  self = [super init];
  NSLog(@"Magnetometer");
  
  if (self) {
    self->_motionManager = [[CMMotionManager alloc] init];
    //Magnetometer
    if([self->_motionManager isMagnetometerAvailable])
    {
      NSLog(@"Magnetometer available");
      /* Start the Magnetometer if it is not active already */
      if([self->_motionManager isMagnetometerActive] == NO)
      {
        NSLog(@"Magnetometer active");
      } else {
        NSLog(@"Magnetometer not active");
      }
    }
    else
    {
      NSLog(@"Magnetometer not Available!");
    }
  }
  return self;
}

RCT_EXPORT_METHOD(setMagnetometerUpdateInterval:(int) intervalMS) {
  NSLog(@"setMagnetometerUpdateInterval: %f", intervalMS);
  double interval = intervalMS/1000.0;
  [self->_motionManager setMagnetometerUpdateInterval:interval];
}

RCT_EXPORT_METHOD(getMagnetometerUpdateInterval:(RCTResponseSenderBlock) cb) {
  double interval = self->_motionManager.magnetometerUpdateInterval;
  NSLog(@"getMagnetometerUpdateInterval: %f", interval);
  cb(@[[NSNull null], [NSNumber numberWithDouble:interval]]);
}

RCT_EXPORT_METHOD(getMagnetometerData:(RCTResponseSenderBlock) cb) {
  double x = self->_motionManager.magnetometerData.magneticField.x;
  double y = self->_motionManager.magnetometerData.magneticField.y;
  double z = self->_motionManager.magnetometerData.magneticField.z;
  
  NSLog(@"getMagnetometerData: %f, %f, %f", x, y, z);
  
  cb(@[[NSNull null], @{
         @"magneticField": @{
             @"x" : [NSNumber numberWithDouble:x],
             @"y" : [NSNumber numberWithDouble:y],
             @"z" : [NSNumber numberWithDouble:z]
             }
         }]
     );
}

RCT_EXPORT_METHOD(startMagnetometerUpdates:(int) intervalMS) {
  NSLog(@"startMagnetometerUpdates");
  double interval = intervalMS/1000.0;
  [self->_motionManager setMagnetometerUpdateInterval:interval];
  [self->_motionManager startMagnetometerUpdates];
  
  /* Receive the ccelerometer data on this block */
  [self->_motionManager startMagnetometerUpdatesToQueue:[NSOperationQueue mainQueue]
                                             withHandler:^(CMMagnetometerData *magnetometerData, NSError *error)
   {
     double x = magnetometerData.magneticField.x;
     double y = magnetometerData.magneticField.y;
     double z = magnetometerData.magneticField.z;
     NSLog(@"startMagnetometerUpdates: %f, %f, %f", x, y, z);
     
     [self.bridge.eventDispatcher sendDeviceEventWithName:@"Magnetometer" body:@{
                                                                                     @"magneticField": @{
                                                                                         @"x" : [NSNumber numberWithDouble:x],
                                                                                         @"y" : [NSNumber numberWithDouble:y],
                                                                                         @"z" : [NSNumber numberWithDouble:z]
                                                                                         }
                                                                                     }];
   }];
  
}

RCT_EXPORT_METHOD(stopMagnetometerUpdates) {
  NSLog(@"stopMagnetometerUpdates");
  [self->_motionManager stopMagnetometerUpdates];
}

@end
