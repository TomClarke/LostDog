//
//  MissingDogsTableViewController.m
//  DogWalkerPro
//
//  Created by Thomas Clarke on 16/08/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import "MissingDogsTableViewController.h"
#import "LostDogs.h"
#import <Parse/Parse.h>

@interface MissingDogsTableViewController ()

@end

@implementation MissingDogsTableViewController
@synthesize LostDogsArray;
@synthesize filteredLostDogsArray;
@synthesize LostDogsSearchBar;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];



    
    LostDogsArray = [NSArray arrayWithObjects:
             /*

                     PFObject *LostDogsObject = [PFObject objectWithClassName:@"LostDogs"];
                     [LostDogsObject setObject: image forKey:@"Photo"];
                     [LostDogsObject setObject:[PFUser currentUser].username forKey:@"Username"];
                     [LostDogsObject setObject:self.PetName.text forKey:@"PetName"];
                     [LostDogsObject setObject:self.Location.text forKey:@"Location"];
                     [LostDogsObject setObject:self.Description.text forKey:@"Description"];
                     [LostDogsObject setObject:self.ContactNo.text forKey:@"ContactNumber"];
                     [LostDogsObject setObject:self.Date.date forKey:@"DateTime"];
                     
                     
                /*  [LostDogs LostDogsOfCategory:@"chocolate" name:@"chocolate bar"],
                  [LostDogs LostDogsOfCategory:@"chocolate" name:@"chocolate chip"],
                  [LostDogs LostDogsOfCategory:@"chocolate" name:@"dark chocolate"],
                  [LostDogs LostDogsOfCategory:@"hard" name:@"lollipop"],
                  [LostDogs LostDogsOfCategory:@"hard" name:@"LostDogs cane"],
                  [LostDogs LostDogsOfCategory:@"hard" name:@"jaw breaker"],
                  [LostDogs LostDogsOfCategory:@"other" name:@"caramel"],
                  [LostDogs LostDogsOfCategory:@"other" name:@"sour chew"],
                  [LostDogs LostDogsOfCategory:@"other" name:@"peanut butter cup"],
                  [LostDogs LostDogsOfCategory:@"other" name:@"gummi bear"], nil];
                 */
    // Initialize the filteredLostDogsArray with a capacity equal to the LostDogsArray's capacity
   // filteredLostDogsArray = [NSMutableArray arrayWithCapacity:[LostDogsArray count]];
    

    // Reload the table
   // [self.tableView reloadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
     Dispose of any resources that can be recreated.
}
                     
#pragma mark - Table view data source



/*
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

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [filteredLostDogsArray count];
    }
	else
	{
        return [LostDogsArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Create a new LostDogs Object
    //LostDogs *LostDogs = nil;
    
    // Check to see whether the normal table or search results table is being displayed and set the LostDogs object from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
      //  LostDogs = [filteredLostDogsArray objectAtIndex:[indexPath row]];
    }
	else
	{
        //LostDogs = [LostDogsArray objectAtIndex:[indexPath row]];
    }
    
    // Configure the cell
   // [[cell textLabel] setText:[LostDogs name]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Perform segue to LostDogs detail
    [self performSegueWithIdentifier:@"LostDogsDetail" sender:tableView];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [[segue identifier] isEqualToString:@"LostDogsDetail"] ) {
        UIViewController *LostDogsDetailViewController = [segue destinationViewController];
        
        // In order to manipulate the destination view controller, another check on which table (search or normal) is displayed is needed
        if(sender == self.searchDisplayController.searchResultsTableView) {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            NSString *destinationTitle = [[filteredLostDogsArray objectAtIndex:[indexPath row]] name];
            [LostDogsDetailViewController setTitle:destinationTitle];
        }
        else {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            NSString *destinationTitle = [[LostDogsArray objectAtIndex:[indexPath row]] name];
            [LostDogsDetailViewController setTitle:destinationTitle];
        }
        
    }
}

#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	// Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
	[self.filteredLostDogsArray removeAllObjects];
    
	// Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    NSArray *tempArray = [LostDogsArray filteredArrayUsingPredicate:predicate];
    
    if(![scope isEqualToString:@"All"]) {
        // Further filter the array with the scope
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.category contains[c] %@",scope];
        tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
    }
    
    filteredLostDogsArray = [NSMutableArray arrayWithArray:tempArray];
}


#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark - Search Button

- (IBAction)goToSearch:(id)sender
{
    // If you're worried that your users might not catch on to the fact that a search bar is available if they scroll to reveal it, a search icon will help them
    // Note that if you didn't hide your search bar, you should probably not include this, as it would be redundant
    [LostDogsSearchBar becomeFirstResponder];
}


@end
@end

