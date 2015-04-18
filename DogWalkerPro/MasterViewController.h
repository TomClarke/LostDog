//
//  MasterViewController.h
//  Geolocations
//
//  Created by Thomas Clarke on 28/07/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//


#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>


@interface MasterViewController : PFQueryTableViewController <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, assign) NSArray *arrayofObjects;

- (IBAction)insertCurrentLocation:(id)sender;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end
