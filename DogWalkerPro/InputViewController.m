//
//  InputViewController.m
//  DogWalkerPro
//
//  Created by Thomas Clarke on 16/07/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import "InputViewController.h"
#import <Parse/Parse.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "CreateProfileTableViewController.h"
#import "MainMenuViewController.h"

@interface InputViewController ()
@property (weak, nonatomic) IBOutlet UITextField *Username;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet UITextField *Email;
@property (weak, nonatomic) IBOutlet UILabel *enteremail;
@property (weak, nonatomic) IBOutlet UIButton *done;


@end

@implementation InputViewController

@synthesize scrollView;


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        // do stuff with the user
         [self performSegueWithIdentifier:@"LoggedIn" sender:self];
    }
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)LoginPressed:(id)sender {

    [PFUser logInWithUsernameInBackground:self.Username.text password:self.Password.text block:^(PFUser *user, NSError *error) {
        if (user) {
            [self performSegueWithIdentifier:@"LoggedIn" sender:self];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[error userInfo][@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }];
}

- (IBAction)forgotPassword:(id)sender {
    _Email.hidden = FALSE;
    _enteremail.hidden = FALSE;
    _done.hidden = FALSE;
    
}
- (IBAction)UserPasswordRequest:(id)sender {
    //NSString address  =
    [PFUser requestPasswordResetForEmailInBackground:self.Email.text];
    _Email.hidden = TRUE;
    _enteremail.hidden = TRUE;
    _done.hidden = TRUE;
    
    [[[UIAlertView alloc] initWithTitle:@"Password Sent" message:@"An email has been sent, please check your inbox" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

@end
