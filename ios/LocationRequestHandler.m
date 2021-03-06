#import <CoreLocation/CoreLocation.h>
#import "LocationRequestHandler.h"

@implementation LocationRequestHandler

RCT_EXPORT_MODULE(LocationRequestHandler);

RCT_REMAP_METHOD(requestLocationPermission,  request_location_resolver:(RCTPromiseResolveBlock)resolve
                 request_location_rejecter:(RCTPromiseRejectBlock)reject)
{
  dispatch_async(dispatch_get_main_queue(),^ {
  if (!_clLocationManager){
    _clLocationManager = [[CLLocationManager alloc] init];
    _clLocationManager.delegate = self;
  }
   [_clLocationManager requestWhenInUseAuthorization];
  self.completionHandler = resolve;
  });
}

RCT_REMAP_METHOD(getLocationStatus,
                 get_status_resolver:(RCTPromiseResolveBlock)resolve
                 get_status_rejecter:(RCTPromiseRejectBlock)reject)
{
  dispatch_async(dispatch_get_main_queue(),^ {
    if (!_clLocationManager){
      _clLocationManager = [[CLLocationManager alloc] init];
      _clLocationManager.delegate = self;
    }
    NSString *status = [self getLocAuthorizationStatus];
    
    resolve(status);
  });
  
}

- (NSString *)getLocAuthorizationStatus {
  NSString *status;
  
  switch (CLLocationManager.authorizationStatus)
  {
    case kCLAuthorizationStatusNotDetermined:
      status = LocationUndetermined;
      break;
    case kCLAuthorizationStatusRestricted:
      status = LocationRestricted;
      break;
    case kCLAuthorizationStatusDenied:
      status = LocationDenied;
      break;
    case kCLAuthorizationStatusAuthorizedAlways:
      status = LocationAuthorizedAlways;
      break;
    case kCLAuthorizationStatusAuthorizedWhenInUse:
      status = LocationAuthorizedWhenInUse;
      break;
    default: status=@"Unknown";
  }
  return status;
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
  dispatch_async(dispatch_get_main_queue(),^ {
      if (status != kCLAuthorizationStatusNotDetermined)
      {
        NSString * currentStatus;
        switch (status)
        {
          case kCLAuthorizationStatusNotDetermined:
            currentStatus = LocationUndetermined;
            break;
          case kCLAuthorizationStatusRestricted:
            currentStatus = LocationRestricted;
            break;
          case kCLAuthorizationStatusDenied:
            currentStatus = LocationDenied;
            break;
          case kCLAuthorizationStatusAuthorizedAlways:
            currentStatus = LocationAuthorizedAlways;
            break;
          case kCLAuthorizationStatusAuthorizedWhenInUse:
            currentStatus = LocationAuthorizedWhenInUse;
            break;
          default: currentStatus=@"Unknown";
        }
        if (self.completionHandler != nil)
        {
          self.completionHandler(currentStatus);
        }
      }
  });
}


@end
