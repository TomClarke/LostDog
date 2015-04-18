//
//  MapTutorialViewController.m
//  MapTutorial
//
//  Created by Thomas Clarke on 28/07/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//


#import "MapTutorialViewController.h"
#import "GeoPointAnnotation.h"
#import "AddMissingDogTableViewController.h"

@implementation MapTutorialViewController
@synthesize _mapView;
@synthesize droppedPin;
@synthesize locationManager;

- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = 10.0f;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters; 
 
    
    [_mapView setMapType:MKMapTypeStandard];
    [_mapView setZoomEnabled:YES];
    CLLocation *_Location = self.locationManager.location;
    CLLocationCoordinate2D coordinate = [_Location coordinate];
    MKCoordinateSpan span = {.latitudeDelta =  0.2, .longitudeDelta =  0.2};
    MKCoordinateRegion region = {coordinate, span};

    [_mapView setRegion:region animated: YES];
    
	UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                      initWithTarget:self action:@selector(handleLongPress:)];
lpgr.minimumPressDuration = 1.0; //user needs to press for 2 seconds
[self._mapView addGestureRecognizer:lpgr];
   
    [self.locationManager stopUpdatingLocation];
    [self.locationManager stopMonitoringSignificantLocationChanges];
     [self.locationManager setDelegate:nil];
  
}



- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self._mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self._mapView convertPoint:touchPoint toCoordinateFromView:self._mapView];
    
    GeoPointAnnotation *annot = [[GeoPointAnnotation alloc] init];
    annot.coordinate = touchMapCoordinate;
    [self._mapView addAnnotation:annot];
    
    droppedPin = touchMapCoordinate;

}

-(IBAction)save:(id)sender{
    [self.locationManager stopUpdatingLocation];
    [self.locationManager stopMonitoringSignificantLocationChanges];
    [self.locationManager setDelegate:nil];

        
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Save"]) {
       
        AddMissingDogTableViewController *missing = (AddMissingDogTableViewController *)[segue destinationViewController];
        [self.locationManager stopUpdatingLocation];
        [self.locationManager stopMonitoringSignificantLocationChanges
         ];
         [self.locationManager setDelegate:nil];
        missing.droppedPin = droppedPin;

    }
   
}

@end
