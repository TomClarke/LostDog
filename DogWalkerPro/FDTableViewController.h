//
//  FDTableViewController.h
//  DogWalkerPro
//
//  Created by Thomas Clarke on 10/09/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>

@interface FDTableViewController : PFQueryTableViewController <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, assign) NSArray *arrayofObjects;



@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end