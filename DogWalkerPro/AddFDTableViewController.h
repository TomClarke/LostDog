//
//  AddFDTableViewController.h
//  DogWalkerPro
//
//  Created by Thomas Clarke on 10/09/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>

@interface AddFDTableViewController : UITableViewController <UITableViewDelegate,
UITableViewDataSource,UITableViewDataSource,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,CLLocationManagerDelegate>

@property BOOL newMedia;
@property BOOL search;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)useCamera:(id)sender;

- (IBAction)useCameraRoll:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *SaveLocation;

@property (nonatomic, retain) CLLocationManager *locationManager;

@property (nonatomic) CLLocationCoordinate2D droppedPin;

@property (nonatomic,strong) UITableView *KeyboardAvoidingVew;

@property (weak, nonatomic) IBOutlet UIDatePicker *Date;
@property (weak, nonatomic) IBOutlet UITextField *Location;
@property (weak, nonatomic) IBOutlet UITextField *Description;
@property (weak, nonatomic) IBOutlet UITextField *ContactNo;
@property (weak, nonatomic) IBOutlet UITextField *PetName;

@property (weak, nonatomic) IBOutlet UIButton *AddPhoto;
@property (weak, nonatomic) IBOutlet UIButton *AddMissingdog;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;

@property (nonatomic, strong) PFObject *searchItem;

@end