#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

static NSString* LocationUndetermined = @"NotDetermined";
static NSString* LocationRestricted = @"Restricted";
static NSString* LocationAuthorizedAlways = @"AuthorizedAlways";
static NSString* LocationAuthorizedWhenInUse = @"AuthorizedWhenInUse";
static NSString* LocationDenied = @"Denied";

@interface LocationRequestHandler : NSObject <RCTBridgeModule, CLLocationManagerDelegate>

@property (copy) void (^completionHandler)(NSString *);
@property (strong, nonatomic) CLLocationManager* clLocationManager;

- (NSString *)getLocAuthorizationStatus;

@end
