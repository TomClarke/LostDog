//
//  AddMissingDogTableViewController.h
//  DogWalkerPro
//
//  Created by Thomas Clarke on 26/07/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface AddMissingDogTableViewController : UITableViewController <UITableViewDelegate,
UITableViewDataSource,UITableViewDataSource,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate>

@property BOOL newMedia;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)useCamera:(id)sender;

- (IBAction)useCameraRoll:(id)sender;





@property (nonatomic,strong) UITableView *KeyboardAvoidingVew;

@property (weak, nonatomic) IBOutlet UIDatePicker *Date;
@property (weak, nonatomic) IBOutlet UITextField *Location;
@property (weak, nonatomic) IBOutlet UITextField *Description;
@property (weak, nonatomic) IBOutlet UITextField *ContactNo;
@property (weak, nonatomic) IBOutlet UITextField *PetName;


@property (weak, nonatomic) IBOutlet UIButton *AddPhoto;
@property (weak, nonatomic) IBOutlet UIButton *AddMissingdog;




@end
