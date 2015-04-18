//
//  SearchViewController.h
//  Geolocations
//
//  Created by Héctor Ramos on 8/16/12.
//

#import <MapKit/MapKit.h>


@interface SearchViewController : UIViewController <MKMapViewDelegate>{ PFGeoPoint *pointStore; }

@property (nonatomic, strong) IBOutlet MKMapView *mapView;


- (void)setInitialLocation:(CLLocation *)aLocation;
@property (nonatomic, retain) CLLocationManager *locationManager;


@property (retain, nonatomic) PFGeoPoint *pointStore;;

@end
