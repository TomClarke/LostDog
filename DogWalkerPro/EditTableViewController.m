//
//  EditTableViewController.m
//  DogWalkerPro
//
//  Created by Thomas Clarke on 11/09/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import "EditTableViewController.h"

#import "EditDetailViewController.h"

@interface EditTableViewController ()

@end

@implementation EditTableViewController


@synthesize arrayofObjects;
@synthesize locationManager = _locationManager;

- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    if (self) {
        // Customize the table
        
        // The className to query on
        self.parseClassName = @"FoundDogs";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"Location";
        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
        self.imageKey = @"Photo";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 50;
        
    }
    
    return self;
}




#pragma mark - UIViewController



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        // Row selection
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        [segue.destinationViewController setEditdetailItem:object];
        
    }
}

- (CLLocationManager *)locationManager {
	
    if (_locationManager != nil) {
		return _locationManager;
	}
	
	_locationManager = [[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    _locationManager.delegate = self;
    
	
	return _locationManager;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.locationManager startUpdatingLocation];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.locationManager stopUpdatingLocation];
}
/*
 arrayofObjects = self.objects;
 
 NSSortDescriptor *titleSorter= [[NSSortDescriptor alloc] initWithKey:@"realdist" ascending:YES];
 
 [arrayofObjects sortedArrayUsingDescriptors:[NSArray arrayWithObject:titleSorter]];
 
 
 */



// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the textKey in the object,
// and the imageView being the imageKey in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    // A date formatter for the creation date.
    
    static NSString *cellIdentifier = @"LocationCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LocationCell"];
    
    if (!cell) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    
    if (tableView != self.searchDisplayController.searchResultsTableView) {
        
        CLLocation *_Location = self.locationManager.location;
        CLLocationCoordinate2D coordinate = [_Location coordinate];
        PFGeoPoint *current = [PFGeoPoint geoPointWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        
        
        PFGeoPoint *destination = [object objectForKey:@"GeoLocation"];
        
        double distance = [current distanceInMilesTo:destination];
        
        //distance = distance - 3559;
        
        
        NSString *realdist = [NSString stringWithFormat:@"miles: %.2f",distance];
        
        
        
        cell.detailTextLabel.text = realdist;
        
        
        
        //NSString *location = object[@"Location"];
        NSString *petName = object[@"PetName"];
        PFFile *photo = object[@"Photo"];
        
        cell.textLabel.text= petName;
        cell.detailTextLabel.text = realdist;
        
        [photo getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                UIImage *photo = [UIImage imageWithData:data];
                // image can now be set on a UIImageView
                //UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
                
                UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(240, 3, 70, 63)];
                imageView.backgroundColor=[UIColor clearColor];
                [imageView setImage:photo];
                cell.accessoryView = imageView;
                //  [imageView release];
            }
        }];
        
    }
    return cell;
}

#pragma mark - PFQueryTableViewController

- (void)objectsWillLoad {
    [super objectsWillLoad];
    [self.locationManager startUpdatingLocation];
    
    // This method is called before a PFQuery is fired to get more objects
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}


// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    
    // If Pull To Refresh is enabled, query against the network by default.
    if (self.pullToRefreshEnabled) {
        query.cachePolicy = kPFCachePolicyNetworkOnly;
    }
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    
    CLLocation *_Location = self.locationManager.location;
    CLLocationCoordinate2D coordinate = [_Location coordinate];
    PFGeoPoint *current = [PFGeoPoint geoPointWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    double distance = 5;
    
    //distance = distance + 3559;
    //[query whereKey:@"GeoLocation" nearGeoPoint:current withinMiles:distance];
    [query whereKey:@"Found" equalTo:[NSNumber numberWithBool:NO]];
    
    [query orderByDescending:@"createdAt"];
    
    
    
    return query;
}





// Override to customize the look of the cell that allows the user to load the next page of objects.
// The default implementation is a UITableViewCellStyleDefault cell with simple labels.

- (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"NextPage";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"Load more...";
    
    return cell;
}






@end
