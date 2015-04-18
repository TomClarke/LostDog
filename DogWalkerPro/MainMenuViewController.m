//
//  MainMenuViewController.m
//  DogWalkerPro
//
//  Created by Thomas Clarke on 05/09/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import "MainMenuViewController.h"
#import <parse/parse.h>

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LogOut:(id)sender {
    [PFUser logOut];
    PFUser *currentUser = [PFUser currentUser];
            [self performSegueWithIdentifier:@"LoggedOut" sender:self];
        
            [[[UIAlertView alloc] initWithTitle:@"Logged Out" message:@"You have logged out" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }

@end
