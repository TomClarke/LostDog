//
//  GeoPointAnnotation.m
//  Geolocations
//
//  Created by Thomas Clarke on 28/07/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//


#import "GeoPointAnnotation.h"

@interface GeoPointAnnotation()
@property (nonatomic, strong) PFObject *object;

@end

@implementation GeoPointAnnotation

@synthesize petName;
#pragma mark - Initialization

- (id)initWithObject:(PFObject *)aObject {
    self = [super init];
    if (self) {
        _object = aObject;
        
        PFGeoPoint *geoPoint = self.object[@"GeoLocation"];
              [self setGeoPoint:geoPoint];
    }
    return self;
}


#pragma mark - MKAnnotation

// Called when the annotation is dragged and dropped. We update the geoPoint with the new coordinates.
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:newCoordinate.latitude longitude:newCoordinate.longitude];
    [self setGeoPoint:geoPoint];
   // [self setGeoPoint:geoPoint petname:petName];
    [self.object setObject:geoPoint forKey:@"GeoLocation"];
    [self.object saveEventually:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // Send a notification when this geopoint has been updated. MasterViewController will be listening for this notification, and will reload its data when this notification is received.
            [[NSNotificationCenter defaultCenter] postNotificationName:@"geoPointAnnotiationUpdated" object:self.object];
        }
    }];
}


#pragma mark - ()

- (void)setGeoPoint:(PFGeoPoint *)geoPoint {
    _coordinate = CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
    
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeStyle = NSDateFormatterMediumStyle;
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    }
    
    static NSNumberFormatter *numberFormatter = nil;
    if (numberFormatter == nil) {
        numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        numberFormatter.maximumFractionDigits = 3;
    }
   
    _title = [dateFormatter stringFromDate:self.object.updatedAt];
    
        
    _subtitle = [NSString stringWithFormat:@"%@, %@", [numberFormatter stringFromNumber:[NSNumber numberWithDouble:geoPoint.latitude]],
              [numberFormatter stringFromNumber:[NSNumber numberWithDouble:geoPoint.longitude]]];
}

@end
