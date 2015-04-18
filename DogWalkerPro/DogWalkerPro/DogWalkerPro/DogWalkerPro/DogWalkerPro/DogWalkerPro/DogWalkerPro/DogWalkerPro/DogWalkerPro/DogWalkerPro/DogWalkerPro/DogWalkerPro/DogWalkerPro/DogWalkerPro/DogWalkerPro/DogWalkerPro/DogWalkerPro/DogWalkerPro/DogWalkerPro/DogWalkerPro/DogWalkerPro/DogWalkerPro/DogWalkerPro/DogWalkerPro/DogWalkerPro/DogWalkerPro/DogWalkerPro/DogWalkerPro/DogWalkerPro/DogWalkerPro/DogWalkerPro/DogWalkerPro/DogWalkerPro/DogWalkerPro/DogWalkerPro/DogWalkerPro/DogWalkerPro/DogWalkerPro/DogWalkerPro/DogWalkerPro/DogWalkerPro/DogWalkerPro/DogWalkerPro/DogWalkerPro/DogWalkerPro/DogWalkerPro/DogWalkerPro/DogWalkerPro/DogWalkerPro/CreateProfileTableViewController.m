//
//  CreateProfileTableViewController.m
//  DogWalkerPro
//
//  Created by Thomas Clarke on 20/07/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import "CreateProfileTableViewController.h"
#import <Parse/Parse.h> 



@implementation CreateProfileTableViewController



// Sent to the delegate to determine whether the sign up request should be submitted to the server.

    
    

    // Uncomment the following line to preserve selection between presentations.
     //self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


  
//Sign Up Button pressed

- (IBAction)CreatePressed:(id)sender {

    //1
    PFUser *user = [PFUser user];
    //2
    user.username = self.Username.text;
    user.password = self.Password.text;
    user.email = self.Email.text;
    
    
    //3
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            //The registration was successful, go to the wall
            [self performSegueWithIdentifier:@"SignUpSuccessful" sender:self];
            
        } else {
            //Something bad has occurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
    
}

/*- (IBAction)Create:(id)sender{
   
    
    NSString *username = _Username.text;
    
    NSString *password = _Password.text;
    
    NSString *dogname1 = _Dogname1.text;
    
    NSString *dogname2 = _Dogname2.text;
    
    NSString *dogname3 = _Dogname3.text;
    
    // UIImage *dogpicture = _Picture.image;
    
    NSString *contactnumber = _ContactNumber.text;
    
    NSString *email = _Email.text;
    
    PFObject *userObject = [PFObject objectWithClassName:@"User"];
    [userObject setObject: username forKey:@"Username"];
    [userObject setObject: password forKey:@"Password"];
    [userObject setObject: dogname1 forKey:@"Dogname1"];
    [userObject setObject: dogname2 forKey:@"Dogname2"];
    [userObject setObject: dogname3 forKey:@"Dogname3"];
   //[userObject setObject: dogpicture forKey:@"Picture"];
    [userObject setObject: contactnumber forKey:@"ContactNumber"];
    [userObject setObject: email forKey:@"Email"];
    [userObject save];
        //3
    [userObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded){
            NSLog(@"Object Uploaded!");
        }
        else{
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error: %@", errorString);
        }
        
    }];
          
    }

    NSString *username = _Username.text;
    
    NSString *password = _Password.text;
    
    NSString *dogname1 = _Dogname1.text;
    
    NSString *dogname2 = _Dogname2.text;
    
    NSString *dogname3 = _Dogname3.text;
    
    // UIImage *dogpicture = _Picture.image;
    
    NSString *contactnumber = _ContactNumber.text;
    
    NSString *email = _Email.text;
    
    
    if (username && password && dogname1 && dogname2 &&dogname3 &&contactnumber &&email && username.length && password.length &&dogname1.length && dogname2.length && dogname3.length & contactnumber.length && email.length) {
        
    
    PFObject *userObject = [PFObject objectWithClassName:@"User"];
    [userObject setObject: username forKey:@"Username"];
          [userObject setObject: password forKey:@"Password"];
        [userObject save];
  
   
    
     PFObject *userObject2 = [PFObject objectWithClassName:@"User"];
     [userObject setObject: password forKey:@"Password"];
 

     PFObject *userObject3 = [PFObject objectWithClassName:@"User"];
     [userObject setObject: dogname1 forKey:@"Dogname1"];
  

    PFObject *userObject4 = [PFObject objectWithClassName:@"User"];
     [userObject setObject: dogname2 forKey:@"Dogname2"];


    PFObject *userObject5 = [PFObject objectWithClassName:@"User"];
     [userObject setObject: dogname3 forKey:@"Dogname3"];
   
     

    //PFObject *userObject6 = [PFObject objectWithClassName:@"User"];
    // [userObject setObject: dogpicture forKey:@"Picture"];
  
  
    PFObject *userObject7 = [PFObject objectWithClassName:@"User"];
     [userObject setObject: contactnumber forKey:@"ContactNumber"];


    PFObject *userObject8 = [PFObject objectWithClassName:@"User"];
     [userObject setObject: email forKey:@"Email"];
    
     [userObject save];
    [userObject2 save];
    [userObject3 save];
    [userObject4 save];
    [userObject5 save];
   // [userObject6 save];
    [userObject7 save]; 
    [userObject8 save];
     
    }
    else{
        
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    }
  */  




#pragma mark - Table view data source

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NavBar";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

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
@end
