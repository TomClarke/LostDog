//
//  AddFDTableViewController.m
//  DogWalkerPro
//
//  Created by Thomas Clarke on 10/09/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import "AddFDTableViewController.h"
#import <Parse/Parse.h>
#import "FDMapViewController.h"
@interface AddFDTableViewController ()

@end

@implementation AddFDTableViewController

@synthesize locationManager = _locationManager;
@synthesize SaveLocation;
@synthesize search;
@synthesize newMedia = _newMedia;
@synthesize droppedPin;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [self.locationManager startUpdatingLocation];
    
    // Listen for annotation updates. Triggers a refresh whenever an annotation is dragged and dropped.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadObjects) name:@"geoPointAnnotiationUpdated" object:nil];
    
    search = TRUE;
}

- (IBAction)back:(id)sender
{
    UIAlertView *message = [[UIAlertView alloc]
                            initWithTitle: @"Not Submitted"
                            message: @"Make sure to scroll to bottom and click submit"
                            delegate: nil
                            cancelButtonTitle:@"OK"
                            otherButtonTitles:nil];
    [message show];
    
    
    [self.locationManager stopUpdatingLocation];
    [self.locationManager stopMonitoringSignificantLocationChanges];
}





- (IBAction)useCamera:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
        _newMedia = YES;
    }
}
- (IBAction)useCameraRoll:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
        _newMedia = NO;
    }
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        _imageView.image = image;
        if (_newMedia)
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo
{
    [picker dismissModalViewControllerAnimated:YES];
    //Place the image in the imageview
    self.imageView.image = img;
}
/*
 - (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
 // If it's a relatively recent event, turn off updates to save power
 CLLocation* location = [locations lastObject];
 NSDate* eventDate = location.timestamp;
 NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
 if (abs(howRecent) < 15.0) {
 // If the event is recent, do something with it.
 NSLog(@"latitude %+.6f, longitude %+.6f\n",
 location.coordinate.latitude,
 location.coordinate.longitude);
 }
 }
 */
- (void)startSignificantChangeUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == self.locationManager)
        _locationManager = [[CLLocationManager alloc] init];
    
    _locationManager.delegate = self;
    [_locationManager startMonitoringSignificantLocationChanges];
}


- (IBAction)AddMissingDog:(id)sender {
    
    
    
    
    // Disable the send button until we are ready
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    // Display the loading spinner
    UIActivityIndicatorView *loadingSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loadingSpinner setCenter:CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height/2.0f)];
    [loadingSpinner startAnimating];
    [self.view addSubview:loadingSpinner];
    
    NSData *pictureData = UIImageJPEGRepresentation(self.imageView.image, 0.9f);
    
    //Upload a new picture
    //1
    PFFile *image = [PFFile fileWithName:@"img" data:pictureData];
    
    // GEopoint
    static NSNumberFormatter *numberFormatter = nil;
	if (numberFormatter == nil) {
		numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        numberFormatter.maximumFractionDigits = 3;
	}
    
    
    
    
    
    
    [image saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded){
            //2
            //Add the image to the object, and add the comment and the user
            PFObject *FoundDogsObject = [PFObject objectWithClassName:@"FoundDogs"];
            PFACL *defaultACL = [PFACL ACL];
            [defaultACL setPublicReadAccess:YES];
            [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
            FoundDogsObject.ACL = defaultACL;
            //[imageObject setObject:file forKey:@"Photo"];
            [FoundDogsObject setObject: image forKey:@"Photo"];
            [FoundDogsObject setObject:[PFUser currentUser].username forKey:@"Username"];
            [FoundDogsObject setObject:self.PetName.text forKey:@"PetName"];
            // [FoundDogsObject setObject:self.Location.text forKey:@"Location"];
            
            if( search == FALSE){
                
                CLLocation *_Location = self.locationManager.location;
                CLLocationCoordinate2D coordinate = [_Location coordinate];
                PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude longitude:coordinate.longitude];
                [FoundDogsObject setObject:geoPoint forKey:@"GeoLocation"];
                
            }
            else {
                
                CLLocationCoordinate2D coordinate = droppedPin;
                
                NSLog(@"latitude THIS IS SUMBITTED %+.6f, longitude %+.6f\n",
                      droppedPin.latitude,
                      droppedPin.longitude);
                
                //CLLocationCoordinate2D coordinate = [_Location coordinate];
                PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude longitude:coordinate.longitude];
                [FoundDogsObject setObject:geoPoint forKey:@"GeoLocation"];
                
            }
            
            
            [FoundDogsObject setObject:self.Description.text forKey:@"Description"];
            [FoundDogsObject setObject:self.ContactNo.text forKey:@"ContactNumber"];
            [FoundDogsObject setObject:self.Date.date forKey:@"DateTime"];
            [FoundDogsObject setObject: [NSNumber numberWithBool:NO]  forKey:@"Found"];
            
            [self.locationManager stopUpdatingLocation];
            [self.locationManager stopMonitoringSignificantLocationChanges];
            [self.locationManager setDelegate:nil];
            //3
            [FoundDogsObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                //4
                if (succeeded){
                    //The registration was successful, go to the wall
                    
                    [self performSegueWithIdentifier:@"AddedMissingDogSuccessful" sender:self];
                }
                else{
                    NSString *errorString = [[error userInfo] objectForKey:@"error"];
                    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [errorAlertView show];
                }
            }];
        }
        else{
            //5
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    } progressBlock:^(int percentDone) {
        NSLog(@"Uploaded: %d %%", percentDone);
    }];
    [self.locationManager stopUpdatingLocation];
    [self.locationManager stopMonitoringSignificantLocationChanges];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


//LOCATION-------------------------------------------------------------------------------

#pragma mark - Table view delegate

#pragma mark - CLLocationManagerDelegate

/**
 Conditionally enable the Search/Add buttons:
 If the location manager is generating updates, then enable the buttons;
 If the location manager is failing, then disable the buttons.
 */

- (CLLocationManager *)locationManager {
	
    if (_locationManager != nil) {
		return _locationManager;
	}
	
	_locationManager = [[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    _locationManager.delegate = self;
    
	
	return _locationManager;
}


#pragma mark - MasterViewController

/**
 Return a location manager -- create one if necessary.
 */

- (IBAction)insertCurrentLocation:(id)sender {
	// If it's not possible to get a location, then return.
	CLLocation *location = self.locationManager.location;
	if (!location) {
        
        [SaveLocation setTitle:@"Error (Use --->)"  forState:UIControlStateNormal] ;
        
        return ;
        
	}
    [SaveLocation setTitle:@"Saved" forState:UIControlStateNormal] ;
    search = FALSE;
    return ;
    
}








@end

