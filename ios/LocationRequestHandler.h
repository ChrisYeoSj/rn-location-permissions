#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface LocationRequestHandler : NSObject <RCTBridgeModule>

@property (copy) void (^completionHandler)(NSString *);
@property (strong, nonatomic) CLLocationManager* clLocationManager;

@end
