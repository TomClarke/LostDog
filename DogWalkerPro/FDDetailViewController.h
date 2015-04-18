//
//  FDDetailViewController.h
//  DogWalkerPro
//
//  Created by Thomas Clarke on 10/09/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
@interface FDDetailViewController : UIViewController

@property (nonatomic, strong) PFObject *FDdetailItem;

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
