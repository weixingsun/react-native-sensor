//
//  Gyroscope.m
//
//  Created by Patrick Williams in beautiful Seattle, WA.
//

#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#import "Gyroscope.h"

@implementation Gyroscope

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

- (id) init {
    self = [super init];
    NSLog(@"Gyroscope");
    
    if (self) {
        self->_motionManager = [[CMMotionManager alloc] init];
        //Gyroscope
        if([self->_motionManager isGyroAvailable])
        {
            NSLog(@"Gyroscope available");
            /* Start the gyroscope if it is not active already */
            if([self->_motionManager isGyroActive] == NO)
            {
                NSLog(@"Gyroscope active");
            } else {
                NSLog(@"Gyroscope not active");
            }
        }
        else
        {
            NSLog(@"Gyroscope not Available!");
        }
    }
    return self;
}

RCT_EXPORT_METHOD(setGyroUpdateInterval:(int) intervalMS) {
    NSLog(@"setGyroUpdateInterval: %f", intervalMS);
    double interval = intervalMS/1000.0;
    [self->_motionManager setGyroUpdateInterval:interval];
}

RCT_EXPORT_METHOD(getGyroUpdateInterval:(RCTResponseSenderBlock) cb) {
    double interval = self->_motionManager.gyroUpdateInterval;
    NSLog(@"getGyroUpdateInterval: %f", interval);
    cb(@[[NSNull null], [NSNumber numberWithDouble:interval]]);
}

RCT_EXPORT_METHOD(getGyroData:(RCTResponseSenderBlock) cb) {
    double x = self->_motionManager.gyroData.rotationRate.x;
    double y = self->_motionManager.gyroData.rotationRate.y;
    double z = self->_motionManager.gyroData.rotationRate.z;
    
    NSLog(@"getGyroData: %f, %f, %f", x, y, z);
    
    cb(@[[NSNull null], @{
             @"rotationRate": @{
                     @"x" : [NSNumber numberWithDouble:x],
                     @"y" : [NSNumber numberWithDouble:y],
                     @"z" : [NSNumber numberWithDouble:z]
                     }
             }]
       );
}

RCT_EXPORT_METHOD(startGyroUpdates:(int) intervalMS) {
    NSLog(@"startGyroUpdates");
    double interval = intervalMS/1000.0;
    [self->_motionManager setGyroUpdateInterval:interval];
    [self->_motionManager startGyroUpdates];
    
    /* Receive the gyroscope data on this block */
    [self->_motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue]
                                      withHandler:^(CMGyroData *gyroData, NSError *error)
     {
         double x = gyroData.rotationRate.x;
         double y = gyroData.rotationRate.y;
         double z = gyroData.rotationRate.z;
         NSLog(@"startGyroUpdates: %f, %f, %f", x, y, z);
         
         [self.bridge.eventDispatcher sendDeviceEventWithName:@"Gyroscope" body:@{
                                                                                 @"rotationRate": @{
                                                                                         @"x" : [NSNumber numberWithDouble:x],
                                                                                         @"y" : [NSNumber numberWithDouble:y],
                                                                                         @"z" : [NSNumber numberWithDouble:z]
                                                                                         }
                                                                                 }];
     }];
    
}

RCT_EXPORT_METHOD(stopGyroUpdates) {
    NSLog(@"stopGyroUpdates");
    [self->_motionManager stopGyroUpdates];
}

@end
