#import <CoreLocation/CoreLocation.h>
#import "LocationRequestHandler.h"

@implementation LocationRequestHandler



RCT_EXPORT_MODULE(LocationRequestHandler);

RCT_EXPORT_METHOD(requestLocationPermission) {
  if (!_clLocationManager){
    _clLocationManager = [[CLLocationManager alloc] init];
  }
   [_clLocationManager requestWhenInUseAuthorization];
}

RCT_REMAP_METHOD(getLocationStatus,
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejector:(RCTPromiseRejectBlock)reject)
{
  if (!_clLocationManager){
    _clLocationManager = [[CLLocationManager alloc] init];
  }
  
  NSString *status;
  
  switch (CLLocationManager.authorizationStatus)
  {
    case kCLAuthorizationStatusNotDetermined:
      status = @"NotDetermined";
      break;
    case kCLAuthorizationStatusRestricted:
      status = @"Restricted";
      break;
    case kCLAuthorizationStatusDenied:
      status = @"Denied";
      break;
    case kCLAuthorizationStatusAuthorizedAlways:
      status = @"AuthorizedAlways";
      break;
    case kCLAuthorizationStatusAuthorizedWhenInUse:
      status = @"AuthorizedWhenInUse";
      break;
  }
  resolve(status);
  
}

@end
