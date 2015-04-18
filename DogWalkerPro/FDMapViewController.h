//
//  FoundDogsMapViewController.h
//  DogWalkerPro
//
//  Created by Thomas Clarke on 10/09/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>




@interface FDMapViewController : UIViewController <MKMapViewDelegate>{
    BOOL _doneInitialZoom;
    
}

#define METERS_PER_MILE 1609.344


@property (weak, nonatomic) IBOutlet MKMapView *_mapView;//This was auto-added by Xcode :]


@property (nonatomic) CLLocationCoordinate2D droppedPin;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *Save;

@property (strong, nonatomic) IBOutlet CLLocationManager * locationManager;

@property (weak, nonatomic) IBOutlet
UIBarButtonItem *MyLocation;

@end

