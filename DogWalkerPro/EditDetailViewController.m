//
//  EditDetailViewController.m
//  DogWalkerPro
//
//  Created by Thomas Clarke on 11/09/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import "EditDetailViewController.h"
#import "FDDetailViewController.h"
#import <Parse/Parse.h>
#import "FDDetailCell.h"
#import "FDDetailViewController.h"
#import "FDGeoAnnotation.h"

@interface EditDetailViewController ()

@end

@implementation EditDetailViewController



@synthesize EditdetailItem;
@synthesize DateLabel;
@synthesize PhotoSet;
@synthesize PetNameLabel;
@synthesize DescriptionText;
@synthesize ContactNoText;
@synthesize foundBtn;
@synthesize FoundText;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.locationManager startUpdatingLocation];
    
    
    self.title = EditdetailItem[@"PetName"];
    
    PFGeoPoint *geoPoint = self.EditdetailItem[@"GeoLocation"];
    
    self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude), MKCoordinateSpanMake(0.01f, 0.01f));
    
	//location.latitude = (double) 51.501468;
	//location.longitude = (double) -0.141596;
    
	// Add the annotation to our map view
    FDGeoAnnotation *annotation = [[FDGeoAnnotation  alloc] initWithObject:self.EditdetailItem];
    [self.mapView addAnnotation:annotation];
	
    
    
    // center our map view around this geopoint
    //self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude), MKCoordinateSpanMake(0.01f, 0.01f));
    
    //self.LocationLabel.text = detailItem[@"Location"];
    
    
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
        
    }
    
    
    self.DateLabel.text = [dateFormatter stringFromDate:self.EditdetailItem[@"DateTime"]];
    self.PetNameLabel.text = EditdetailItem[@"PetName"];
    self.DescriptionText.text = EditdetailItem[@"Description"];
    self.ContactNoText.text = EditdetailItem[@"ContactNumber"];
    NSNumber *found = EditdetailItem[@"Found"];
    
    if (found == 0) {
     self.FoundText.text = @"NotFound";
    }
    else{
       self.FoundText.text = @"Found";
    }
    PFFile *photo = EditdetailItem[@"Photo"];
    //self.detailItem[@"Photo"] = [UIImage imageNamed:PhotoSet.imageFile];
    
    [photo getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            UIImage *photo = [UIImage imageWithData:data];
            // image can now be set on a UIImageView
            //UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
            [PhotoSet setImage:photo];
            self.PhotoSet.image = photo;
            //  [imageView release];
        }
    }];
    
	
    
}
// When a map annotation point is added, zoom to it (1500 range)
- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{
	MKAnnotationView *annotationView = [views objectAtIndex:0];
	id <MKAnnotation> mp = [annotationView annotation];
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate], 1500, 1500);
	[mv setRegion:region animated:YES];
	[mv selectAnnotation:mp animated:YES];
}


- (void)viewDidUnload
{
   [self setFoundText:nil];
    [self setDateLabel:nil];
    [self setPhotoSet:nil];
    [self setPetNameLabel:nil];
    [self setDescriptionText:nil];
    [self setContactNoText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


 - (IBAction)Found:(id)sender {
 [self.EditdetailItem setObject: [NSNumber numberWithBool:YES]  forKey:@"Found"];
     PFACL *defaultACL = [PFACL ACL];
     [defaultACL setPublicReadAccess:YES];
     [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
     EditdetailItem.ACL = defaultACL;
 [foundBtn setTitle:@"Dog Found"];
 [foundBtn setTintColor:[UIColor grayColor]];
 }
 
@end
