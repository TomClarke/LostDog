//
//  DetailViewController.h
//  Geolocations
//
//  Created by Thomas Clarke on 28/07/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, strong) PFObject *detailItem;

@property (weak, nonatomic) IBOutlet UIImageView *PhotoSet;
@property (weak, nonatomic) IBOutlet UILabel *DateLabel;
@property (weak, nonatomic) IBOutlet UILabel *LocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *PetNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *DescriptionText;
@property (weak, nonatomic) IBOutlet UITextView *ContactNoText;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *foundBtn;

@property (nonatomic, weak)MKPointAnnotation;
@end
