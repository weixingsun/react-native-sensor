//
//  Magnetometer.h
//
//  Created by Patrick Williams in beautiful Seattle, WA.
//

#import "RCTBridgeModule.h"
#import <CoreMotion/CoreMotion.h>

@interface Magnetometer : NSObject <RCTBridgeModule> {
  CMMotionManager *_motionManager;
}
- (void) setMagnetometerUpdateInterval:(int) intervalMS;
- (void) getMagnetometerUpdateInterval:(RCTResponseSenderBlock) cb;
- (void) getMagnetometerData:(RCTResponseSenderBlock) cb;
- (void) startMagnetometerUpdates:(int) intervalMS;
- (void) stopMagnetometerUpdates;

@end
