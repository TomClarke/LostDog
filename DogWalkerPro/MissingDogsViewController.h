//
//  MissingDogsViewController.h
//  DogWalkerPro
//
//  Created by Thomas Clarke on 28/07/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>


@interface MissingDogsViewController : PFQueryTableViewController

@property (nonatomic, retain) CLLocationManager *locationManager;
@end
