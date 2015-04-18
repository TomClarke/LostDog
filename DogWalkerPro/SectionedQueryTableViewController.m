//
//  SectionedQueryTableViewController.m
//  DogWalkerPro
//
//  Created by Thomas Clarke on 16/08/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import "SectionedQueryTableViewController.h"

@interface SectionedQueryTableViewController()
@property (nonatomic, retain) NSMutableDictionary *sections;
@property (nonatomic, retain) NSMutableDictionary *sectionToLocationTypeMap;
@end

@implementation SectionedQueryTableViewController

@synthesize sections = _sections;
@synthesize sectionToLocationTypeMap = _sectionToLocationTypeMap;


- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    if (self) {
        // Customize the table
        
        // The className to query on
        self.parseClassName = @"LostDogs";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"Location";
        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
         //self.imageKey = @"Photo";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 25;
    }
   
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.sections.allKeys.count;
}

- (NSString *)LocationTypeForSection:(NSInteger)section {
    return [self.sectionToLocationTypeMap objectForKey:[NSNumber numberWithInt:section]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    NSString *LocationType = [self LocationTypeForSection:section];
    NSArray *rowIndecesInSection = [self.sections objectForKey:LocationType]; return rowIndecesInSection.count;
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    [self.sections removeAllObjects];
    [self.sectionToLocationTypeMap removeAllObjects];
    
    NSInteger section = 0;
    NSInteger rowIndex = 0;
    for (PFObject *object in self.objects) {
        NSString *LocationType = [object objectForKey:@"Location"];
        NSMutableArray *objectsInSection = [self.sections objectForKey:LocationType];
        if (!objectsInSection) {
            objectsInSection = [NSMutableArray array];
            
            [self.sectionToLocationTypeMap setObject:LocationType forKey:[NSNumber numberWithInt:section++]];
        }
        
        [objectsInSection addObject:[NSNumber numberWithInt:rowIndex++]];
        [self.sections setObject:objectsInSection forKey:LocationType];
    }
}

- (PFObject *)objectAtIndexPath:(NSIndexPath *)indexPath {NSString *LocationType = [self LocationTypeForSection:indexPath.section];
    
    NSArray *rowIndecesInSection = [self.sections objectForKey:LocationType];
    
    NSNumber *rowIndex = [rowIndecesInSection objectAtIndex:indexPath.row];
    return [self.objects objectAtIndex:[rowIndex intValue]];
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    
    if (self.pullToRefreshEnabled) {
        query.cachePolicy = kPFCachePolicyNetworkOnly;
    }
    
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByAscending:@"createdAt"];
    
    return query;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *sectionHeader = [[UILabel alloc] initWithFrame:CGRectNull];
    sectionHeader.backgroundColor = [UIColor groupTableViewBackgroundColor];
   // sectionHeader.textAlignment = UITextAlignmentCenter;
    sectionHeader.font = [UIFont boldSystemFontOfSize:26];
    sectionHeader.textColor = [UIColor whiteColor];
    sectionHeader.text = [self LocationTypeForSection:section];
    return sectionHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"Cell";
    
    PFTableViewCell *cell = (PFTableViewCell *)[tableView   dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault    reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [object objectForKey:@"PetName"];
    cell.detailTextLabel.text = [object objectForKey:@"Location"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([[segue identifier] isEqualToString:@"LostDogsDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFObject *object = [self objectAtIndexPath:indexPath];
        PFFile *file = [object objectForKey:@"PetName"];
        [[segue destinationViewController] setFile:file];
        
    }
}

@end


/*
#pragma mark - PFQueryTableViewController

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
    
    [self.sections removeAllObjects];
    [self.sectionToSportTypeMap removeAllObjects];
    
    NSInteger section = 0;
    NSInteger rowIndex = 0;
    for (PFObject *object in self.objects) {
        NSString *Location = [object objectForKey:@"Location"];
        NSMutableArray *objectsInSection = [self.sections objectForKey:Location];
        if (!objectsInSection) {
            objectsInSection = [NSMutableArray array];
            
            // this is the first time we see this sportType - increment the section index
            [self.sectionToSportTypeMap setObject:Location forKey:[NSNumber numberWithInt:section++]];
        }
        
        [objectsInSection addObject:[NSNumber numberWithInt:rowIndex++]];
        [self.sections setObject:objectsInSection forKey:Location];
    }
   
}

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
    
    // Order by sport type
    [query orderByAscending:@"Location"];
  
    return query;
}

-(PFObject *)objectAtIndexPath:(NSIndexPath *)indexPath {
     NSLog(@"TEST4.1");
    NSString *Location = [self sportTypeForSection:indexPath.section];
    NSArray *rowIndecesInSection = [self.sections objectForKey:Location];
    NSNumber *rowIndex = [rowIndecesInSection objectAtIndex:indexPath.row];
   NSLog(@"TEST4");
    return [self.objects objectAtIndex:[rowIndex intValue]];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return self.sections.allKeys.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sportType = [self sportTypeForSection:section];
    NSArray *rowIndecesInSection = [self.sections objectForKey:sportType];
    NSLog(@"TEST6");
    return rowIndecesInSection.count;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *sportType = [self sportTypeForSection:section];
    NSLog(@"TEST7");
    return sportType;
    
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    NSLog(@"TEST8.1");
    PFObject * selectedObject = [self objectAtIndexPath:indexPath];
     NSLog(@"TEST8");
}


#pragma mark - ()

- (NSString *)sportTypeForSection:(NSInteger)section {
   NSLog(@"TEST9");
    return [self.sectionToSportTypeMap objectForKey:[NSNumber numberWithInt:section]];
    
}

@end
*/