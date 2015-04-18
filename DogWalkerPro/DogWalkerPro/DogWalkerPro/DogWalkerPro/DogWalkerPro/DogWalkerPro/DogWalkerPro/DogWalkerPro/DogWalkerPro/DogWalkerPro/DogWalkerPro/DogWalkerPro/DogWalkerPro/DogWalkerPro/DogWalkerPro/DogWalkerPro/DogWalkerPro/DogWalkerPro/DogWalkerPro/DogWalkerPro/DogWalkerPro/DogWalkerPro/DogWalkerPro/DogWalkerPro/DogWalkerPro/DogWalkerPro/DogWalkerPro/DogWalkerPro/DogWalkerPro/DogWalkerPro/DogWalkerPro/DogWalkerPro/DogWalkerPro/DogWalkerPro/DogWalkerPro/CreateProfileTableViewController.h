//
//  CreateProfileTableViewController.h
//  DogWalkerPro
//
//  Created by Thomas Clarke on 20/07/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CreateProfileTableViewController : UITableViewController <UITableViewDelegate,
UITableViewDataSource,UITableViewDataSource>


@property (nonatomic,strong) UITableView *TPKeyboardAvoidingTableView;



@property (weak, nonatomic) IBOutlet UITextField *Username;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet UITextField *Dogname1;
@property (weak, nonatomic) IBOutlet UITextField *Dogname2;
@property (weak, nonatomic) IBOutlet UITextField *Dogname3;
@property (weak, nonatomic) IBOutlet UITextField *ContactNumber;
@property (weak, nonatomic) IBOutlet UITextField *Email;
@property (weak, nonatomic) IBOutlet UIImageView *Picture;

@property (weak, nonatomic) IBOutlet UIButton *Create;


@end
